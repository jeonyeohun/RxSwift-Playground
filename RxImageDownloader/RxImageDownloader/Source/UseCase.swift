//
//  UseCase.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import Foundation
import RxSwift

class UseCase {
    let repository: RepositoryProtocol
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchFirst() -> Observable<URL> {
        return self.repository.fetchSwiftImageURL()
    }
    func fetchSecond() -> Observable<URL> {
        return self.repository.fetchSwiftUIImageURL()
    }
}
