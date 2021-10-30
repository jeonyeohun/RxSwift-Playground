//
//  ViewModel.swift
//  RxCounter
//
//  Created by 전여훈 on 2021/10/30.
//

import Foundation
import RxSwift

class ViewModel {
    let useCase: UseCase
    init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    func plusButtonDidTap() -> Observable<String> {
        return self.useCase.increaseCounter()
            .map({ "now: \($0)" })
    }
}
