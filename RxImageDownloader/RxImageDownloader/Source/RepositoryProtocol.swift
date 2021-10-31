//
//  RepositoryProtocol.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import Foundation
import RxSwift

protocol RepositoryProtocol {
    func fetchSwiftImageURL() -> Observable<URL>
    func fetchSwiftUIImageURL() -> Observable<URL>
}
