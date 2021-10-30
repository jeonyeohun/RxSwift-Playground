//
//  ViewController.swift
//  RxValidator
//
//  Created by 전여훈 on 2021/10/30.
//

import UIKit
import RxSwift
import RxCocoa

enum FieldState {
    case empty, valid, invalid
}

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    let idFieldObservable = BehaviorSubject(value: "")
    let pwdFieldObservable = BehaviorSubject(value: "")
    let idValidity = BehaviorSubject(value: FieldState.empty)
    let pwdValidity = BehaviorSubject(value: FieldState.empty)
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    private func configureInvalidUI(of textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemRed.cgColor
    }
    private func configureValidUI(of textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGreen.cgColor
    }
    private func configureEmptyUI(of textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    private func bindUI() {
        self.idField.rx.text.orEmpty
            .bind(to: self.idFieldObservable)
            .disposed(by: self.disposeBag)
        self.pwdField.rx.text.orEmpty
            .bind(to: self.pwdFieldObservable)
            .disposed(by: self.disposeBag)
        self.idFieldObservable
            .map( validID )
            .bind(to: self.idValidity)
            .disposed(by: self.disposeBag)
        self.idValidity
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { validResult in
                self.updateFieldUI(with: validResult, of: self.idField)
            })
            .disposed(by: disposeBag)
        self.pwdFieldObservable
            .map( validPwd )
            .bind(to: self.pwdValidity)
            .disposed(by: self.disposeBag)
        self.pwdValidity
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { validResult in
                self.updateFieldUI(with: validResult, of: self.pwdField)
            })
            .disposed(by: self.disposeBag)
        Observable.combineLatest(idValidity, pwdValidity, resultSelector: { $0 == .valid && $1 == .valid })
            .subscribe(onNext: { value in
                self.nextButton.isEnabled = value
            })
            .disposed(by: self.disposeBag)
        
    }
    private func updateFieldUI(with state: FieldState, of textField: UITextField) {
        switch state {
        case .empty:
            self.configureEmptyUI(of: textField)
        case .valid:
            self.configureValidUI(of: textField)
        case .invalid:
            self.configureInvalidUI(of: textField)
        }
    }
    
    private func validID(id: String) -> FieldState {
        guard !id.isEmpty else { return .empty }
        return id.filter({ $0.isNumber }).count > 0 && id.count > 3 ? .valid : .invalid
    }
    private func validPwd(pwd: String) -> FieldState {
        guard !pwd.isEmpty else { return .empty }
        return pwd.count > 5 ? .valid : .invalid
    }
}

