//
//  NetworkServiceProtocol.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case connectionError, notFoundError
}

protocol NetworkServiceProtocol {
    func fetchResource(url: String) -> Observable<String>
}
