//
//  BaseViewModel.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import Foundation
import Combine

class BaseViewModel {
    
    weak var viewController : BaseViewController?
    var bindings = Set<AnyCancellable>()
    let isDecodeError = PassthroughSubject<String,Never>()
    
    init() {
        
    }
    
    deinit {
        debugPrint("Deinit \(type(of: self))")
    }
    
    func bindViewModel(in viewController: BaseViewController? = nil){
        self.viewController = viewController
    }
}
