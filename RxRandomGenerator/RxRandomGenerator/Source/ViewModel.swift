//
//  ViewModel.swift
//  RxRandomGenerator
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
    
    func buttonDidTap() -> Observable<String>{
        return self.useCase.generateRandomPeople()
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .flatMap({ person in
                return Observable.just("순번: \(person.id) 이름: \(person.name) 성별: \(person.sex == "M" ? "남성" : "여성")")
            })
    }
}
