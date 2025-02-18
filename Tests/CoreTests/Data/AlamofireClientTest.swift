//
//  AlamofireClientTest.swift
//  
//
//  Created by Apple Josal on 18/02/25.
//

import XCTest
@testable import Core
import RxSwift
import Alamofire

final class AlamofireClientTest: XCTestCase {
    var client: HttpClient!
    var urlRequest: URLRequest!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        client = AlamofireClients()
        urlRequest = MockMovieEndpoint.list.urlRequest
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        MockURLProtocol.stubError = nil
        client = nil
        urlRequest = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testAlamofire_whenGivenData_shouldReturnTrue() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        client = AlamofireClients(URLSessionConfig: config)
        
        let mockResponseData = "{\"status\": \"ok\"}"
        MockURLProtocol.stubResponseData = mockResponseData.data(using: .utf8)
        
        let expectation = XCTestExpectation(description: "Observer should receive data")
        client.load(request: urlRequest)
            .observe(on: MainScheduler.instance)
            .subscribe { (response: MockMovieResponse) in
                XCTAssertEqual(response.status, "ok")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testAlamofire_whenGivenNoData_shouldReturnError() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        client = AlamofireClients(URLSessionConfig: config)
        
        MockURLProtocol.stubError = NSError(domain: "MockError", code: 1001)
        
        let expectation = XCTestExpectation(description: "Observer should receive data")
        client.load(request: urlRequest)
            .observe(on: MainScheduler.instance)
            .subscribe { (_: MockMovieResponse) in
                XCTFail()
                expectation.fulfill()
            } onError: { error in
                if let afError = error as? AFError,
                   let underlyingError = afError.underlyingError as NSError? {
                    print("Domain error ", underlyingError.domain)
                    XCTAssertEqual(underlyingError.domain, "MockError")
                    XCTAssertEqual(underlyingError.code, 1001)
                    expectation.fulfill()
                } else {
                    XCTFail()
                    expectation.fulfill()
                }
            }
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 5)
    }
}

public enum MockMovieEndpoint: Endpoint {
    case list
    
    public var baseURL: String {
        "https://example.com"
    }
    public var path: String {
        "/3/movie/now_playing"
    }
    
    public var method: Core.HttpMethod {
        .get
    }
    
    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    public var body: Data? {
        nil
    }
    public var queryParameters: [String : String]? {
        ["api_key": "keysecret"]
    }
}
