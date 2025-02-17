//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import RxSwift

public struct Interactor<Request, Response, R: Repository>: UseCase where R.Request == Request, R.Response == Response {
    private let repository: R
    
    public init(repository: R) {
        self.repository = repository
    }
    
    public func execute(request: Request?) -> Observable<Response> {
        repository.execute(request: request)
    }
}
