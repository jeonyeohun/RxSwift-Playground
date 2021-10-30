//
//  ViewController.swift
//  RxCounter
//
//  Created by 전여훈 on 2021/10/27.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    var viewModel: ViewModel?
    var disposeBag: DisposeBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel(useCase: UseCase())
    }
    @IBAction func plusButtonDidTap(_ sender: Any) {
        self.viewModel?.plusButtonDidTap()
            .subscribe(onNext: { newValue in
                self.counterLabel.text = newValue
            })
            .disposed(by: self.disposeBag ?? DisposeBag())
    }
}

