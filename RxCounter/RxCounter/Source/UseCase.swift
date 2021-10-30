//
//  UseCase.swift
//  RxCounter
//
//  Created by 전여훈 on 2021/10/30.
//

import Foundation
import RxSwift

class UseCase {
    var model = 0
    init() {
    }
    
    func increaseCounter() -> Observable<Int> {
        model += 1
        return Observable.just(model)
    }
}
