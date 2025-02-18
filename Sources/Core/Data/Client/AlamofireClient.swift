//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import RxSwift
import Alamofire
import Foundation

public class AlamofireClient: HttpClient {
    var session: Session?
    
    public init(URLSessionConfig configuration: URLSessionConfiguration = URLSessionConfiguration.default, timeoutInterval: TimeInterval = 120) {
            configuration.timeoutIntervalForRequest = timeoutInterval
            configuration.timeoutIntervalForResource = timeoutInterval
            self.session = Session(configuration: configuration)
    }
    
    public func load<T: Decodable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            self.session?.request(request)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let result):
                        observer.onNext(result)
                    case .failure(let failure):
                        observer.onError(failure)
                    }
                }
            
            return Disposables.create()
        }
    }
}
