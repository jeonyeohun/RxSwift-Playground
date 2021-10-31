//
//  ViewModel.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import Foundation
import RxSwift

class ViewModel {
    let useCase: UseCase
    let firstImageURL: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    let secondImageURL: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    
    init(useCase: UseCase) {
        self.useCase = useCase
        _ = self.useCase.fetchFirst()
            .subscribe(onNext: { imageURL in
                self.firstImageURL.onNext(imageURL)
            })
        _ = self.useCase.fetchSecond()
            .subscribe(onNext: { imageURL in
                self.secondImageURL.onNext(imageURL)
            })
    }
}
