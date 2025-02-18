import XCTest
@testable import Core
import RxSwift

final class CoreTests: XCTestCase {
    var client: HttpClient!
    var urlRequest: URLRequest!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        client = AlamofireClients()
        let url = URL(string: "https://example.com")!
        urlRequest = try? URLRequest(url: url, method: .get)
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
    
    func testURL_whenGivenRequest_shouldReturnValidURL() {
        let expectation = XCTestExpectation(description: "Observer should receive data")
        
        if let url = urlRequest.url {
            XCTAssertEqual(url.absoluteString, "https://example.com")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

public struct MockMovieResponse: Decodable {
    let status: String
    init(status: String) {
        self.status = status
    }
}
