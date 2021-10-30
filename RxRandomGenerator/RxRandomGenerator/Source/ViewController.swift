//
//  ViewController.swift
//  RxRandomGenerator
//
//  Created by 전여훈 on 2021/10/30.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    var viewModel: ViewModel?
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel(useCase: UseCase())
    }
    @IBAction func buttonDidTap(_ sender: Any) {
        self.infoLabel.text = ""
        self.viewModel?.buttonDidTap()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { person in
                    self.infoLabel.text = (self.infoLabel.text ?? "") + person + "\n"
                },
                onCompleted: {
                    self.infoLabel.text = (self.infoLabel.text ?? "") + "로드완료!"
                }
            )
            .disposed(by: self.disposeBag)
    }
}

