//
//  Repository.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import Foundation
import RxSwift

class Repository: RepositoryProtocol {
    let service: NetworkServiceProtocol
    let baseURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func fetchSwiftImageURL() -> Observable<URL> {
        return self.service.fetchResource(url: "1")
            .map( { self.baseURL.appendingPathComponent($0)} )
    }
    
    func fetchSwiftUIImageURL() -> Observable<URL> {
        return self.service.fetchResource(url: "2")
            .map( { self.baseURL.appendingPathComponent($0)} )
    }
    
    
}
