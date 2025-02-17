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
