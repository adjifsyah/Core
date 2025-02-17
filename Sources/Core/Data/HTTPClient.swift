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

public class NetworkConfiguration {
    static let shared: ((String, String) -> NetworkConfiguration) = { host, apiKey in
        NetworkConfiguration(host: host, apiKey: apiKey)
    }
    
    public init(
        host: String,
        apiKey: String
    ) {
        self.host = host
        self.apiKey = apiKey
    }
    
    var host: String
    var apiKey: String
}
