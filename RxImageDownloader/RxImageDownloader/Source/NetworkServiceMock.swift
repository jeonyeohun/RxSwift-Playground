//
//  NetworkService.swift
//  RxImageDownloader
//
//  Created by 전여훈 on 2021/10/31.
//

import Foundation
import RxSwift

class NetworkServiceMock: NetworkServiceProtocol {

    func fetchResource(url: String) -> Observable<String> {
        Observable.create() { emitter in
            DispatchQueue.global(qos: .background).async {
                if url == "1" {
                    sleep(UInt32(Int.random(in: 0...10)))
                    return emitter.onNext("swift.png")
                } else {
                    sleep(UInt32(Int.random(in: 0...10)))
                    return emitter.onNext("swiftui.png")
                }
            }
            return Disposables.create()
        }
    }
}
