//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import RxSwift

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}

public protocol RemoteDataSourceLmpl {
    func load<D: Decodable>(endpoint: String, method: String, params: [String: String]?) -> Observable<D>
}
