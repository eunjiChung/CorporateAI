//
//  CANetworkAdapter.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import Moya
import RxSwift

enum ResponseCode: Int, Codable {
    case success = 200
}

struct CANetworkAdapter {

    enum ResponseType: String, Codable {
        case success
    }

    struct Error: Codable {
        var code: Int?
        var message: String?
//        var meta: KMV5ResponseMeta?
    }

    struct KMV5ResponseMeta: Codable {
        var description: String?
    }

    // SSL 설정 참고 : https://github.com/Moya/Moya/issues/992
    static let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    @discardableResult
    static func request<T: TargetType>(target: T,
                                       success successCallback: @escaping (Response) -> Void,
                                       progress progressCallback: ((ProgressResponse) -> Void)? = nil,
                                       error errorCallback: @escaping (Swift.Error) -> Void,
                                       failure failureCallback: @escaping (MoyaError) -> Void) -> Cancellable {
        let cancellable = provider.request(MultiTarget(target), progress: { (progress) in
               progressCallback?(progress)
        }, completion: { (result) in
            switch result {
            case .success(let response):
                self.printCurl(for: target, request: response.request)

                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    // 에러처리
                }
            case .failure(let error):
                self.printCurl(for: target, request: error.response?.request)
                failureCallback(error)
            }
        })

        return cancellable
    }

    static func requestRx<T: TargetType>(target: T) -> Observable<Data> {
        return Observable.create { emitter -> Disposable in
            request(target: target, success: { response in
                emitter.onNext(response.data)
                emitter.onCompleted()
            }, error: { error in
                emitter.onError(error)
            }, failure: { failError in
                emitter.onError(failError)
            })
            return Disposables.create()
        }
    }

    private static func printCurl(for target: TargetType, request: URLRequest?) {
        #if DEBUG
        guard let request = request else { return }
        let message: String = "\ntarget: \(target)\n"
        #endif
    }
}
