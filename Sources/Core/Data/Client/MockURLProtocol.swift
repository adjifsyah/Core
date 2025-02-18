//
//  File.swift
//  
//
//  Created by Apple Josal on 18/02/25.
//

import Foundation

public class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var stubError: Error?
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        if let error = MockURLProtocol.stubError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else if let data = MockURLProtocol.stubResponseData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }

    
    public override func stopLoading() { }
}

