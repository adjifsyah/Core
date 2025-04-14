//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import RxSwift

public class GetListPresenter<Request, Response, Interactor: UseCases>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    
    private let disposeBag = DisposeBag()
    private let useCase: Interactor
    
    @Published public var list: [Response] = []
    @Published public var msgError: String = ""
    
    @Published public var isLoading: Bool = false
    @Published public var isAlert: Bool = false
    
    public init(useCase: Interactor) {
        self.useCase = useCase
    }
    
    public func getList(request: Request?) {
        isLoading = true
        useCase.execute(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isLoading = false
                self.list = result
                
            } onError: { error in
                self.msgError = error.localizedDescription
                self.isLoading = false
                self.isAlert = true
            }
            .disposed(by: disposeBag)
    }
}
