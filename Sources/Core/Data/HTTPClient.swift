//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import RxSwift

protocol HttpClient {
    func load(url: URL, method: String, params: [String: String]?) -> Observable<Data>
}
