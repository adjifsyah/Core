//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import RxSwift

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> Observable<Response>
    func add(entities: [Response]) -> Observable<Bool>
    func update(id: Int, entity: Response) -> Observable<Bool>
    func delete(id: Int) -> Observable<Bool>
}
