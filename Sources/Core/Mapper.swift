//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformEntityToDomain(entity: Entity) -> Domain
    func transformResponseToDomain(response: Response) -> Domain
    func transformDomainToEntity(domain: Domain) -> Entity
}
