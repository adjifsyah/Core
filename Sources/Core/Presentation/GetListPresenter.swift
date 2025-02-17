//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import RxSwift

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    
    private let disposeBag = DisposeBag()
    private let useCase: Interactor
    
    @Published var list: [Response] = []
    @Published var msgError: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isAlert: Bool = false
    
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
