//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import RxSwift

public protocol UseCases {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
