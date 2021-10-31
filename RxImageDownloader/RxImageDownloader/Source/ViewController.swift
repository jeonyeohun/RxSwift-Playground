//
//  ViewController.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel: ViewModel?
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(
            useCase: UseCase(
                repository: Repository(service: NetworkServiceMock())
            )
        )
        self.bindUI()
    }
    
    func bindUI() {
        guard let viewModel = viewModel else {
            return
        }
        self.viewModel?.firstImageURL
            .map({ imageURL -> UIImage in
                guard let imageURL = imageURL else {
                    return UIImage(systemName: "xmark.square")!
                }
                let image = try! Data(contentsOf: imageURL)
                return UIImage(data: image)!
            })
            .bind(to: self.firstImage.rx.image)
            .disposed(by: disposeBag)
        self.viewModel?.secondImageURL
            .map({ imageURL -> UIImage in
                guard let imageURL = imageURL else {
                    return UIImage(systemName: "xmark.square")!
                }
                let image = try! Data(contentsOf: imageURL)
                return UIImage(data: image)!
            })
            .bind(to: self.secondImage.rx.image)
            .disposed(by: disposeBag)
        Observable.combineLatest(viewModel.firstImageURL, viewModel.secondImageURL, resultSelector: { $0 != nil && $1 != nil })
            .map({ result in result ? "완료!" : "로딩중..." })
            .bind(to: self.resultLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}

