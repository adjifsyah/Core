//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import RxSwift
import Alamofire
import Foundation
import Core

public class AlamofireClient: HttpClient {
    var session: Session?
    
    public init(URLSessionConfig configuration: URLSessionConfiguration = URLSessionConfiguration.default, timeoutInterval: TimeInterval = 120) {
            configuration.timeoutIntervalForRequest = timeoutInterval
            configuration.timeoutIntervalForResource = timeoutInterval
            self.session = Session(configuration: configuration)
    }
    
    public func load(request: URLRequest) -> Observable<Data> {
        return Observable<Data>.create { observer in
            self.session?.request(request)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        if let data {
                            observer.onNext(data)
                        } else {
                            observer.onError(NSError(domain: "Unknown data", code: 1001))
                        }
                    case .failure(let failure):
                        observer.onError(failure)
                    }
                }
            
            return Disposables.create()
        }
    }
}
