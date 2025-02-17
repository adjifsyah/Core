//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import RxSwift

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
