//
//  UseCase.swift
//  RxRandomGenerator
//
//  Created by 전여훈 on 2021/10/30.
//

import Foundation
import RxSwift

class UseCase {
    func generateRandomPeople() -> Observable<Person> {
        var people = [Person]()
        (0..<5).forEach({ number in
            people.append(
                Person(
                    id: number,
                    name: ["A", "B", "C", "D", "E", "F", "G"].randomElement() ?? "A",
                    sex: ["M", "F"].randomElement() ?? "M"
                )
            )
        })
        return Observable<Person>.from(people)
    }
}
