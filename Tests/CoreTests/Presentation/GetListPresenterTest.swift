//
//  GetListPresenterTest.swift
//  
//
//  Created by Apple Josal on 18/02/25.
//

import XCTest
@testable import Core
import RxSwift

class GetListPresenterTests: XCTestCase {
    
    private var presenter: GetListPresenter<String, String, MockUseCase>!
    private var mockUseCase: MockUseCase!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockUseCase()
        presenter = GetListPresenter(useCase: mockUseCase)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        presenter = nil
        mockUseCase = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testGetListSuccess() {
        // Given
        let expectedData = ["Item1", "Item2", "Item3"]
        mockUseCase.result = .just(expectedData)
        
        // When
        presenter.getList(request: "test")
        
        // Then
        let expectation = XCTestExpectation(description: "Wait for data to load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.presenter.list, expectedData)
            XCTAssertFalse(self.presenter.isLoading)
            XCTAssertFalse(self.presenter.isAlert)
            XCTAssertEqual(self.presenter.msgError, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetListFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        mockUseCase.result = .error(expectedError)
        
        // When
        presenter.getList(request: "test")
        
        // Then
        let expectation = XCTestExpectation(description: "Wait for error handling")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.presenter.list.isEmpty)
            XCTAssertFalse(self.presenter.isLoading)
            XCTAssertTrue(self.presenter.isAlert)
            XCTAssertEqual(self.presenter.msgError, "Failed to fetch data")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}

class MockUseCase: UseCase {
    typealias Request = String
    typealias Response = [String]
    
    var result: Observable<[String]> = .just([])
    
    func execute(request: String?) -> Observable<[String]> {
        return result
    }
}
