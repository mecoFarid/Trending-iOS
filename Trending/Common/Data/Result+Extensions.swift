//
//  Result+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 06.12.22.
//

import Foundation
extension Result{
    
    @discardableResult
    func onSuccess(closure: (Success) -> Void) -> Result<Success, Failure>{
        switch self {
        case .success(let success):
            closure(success)
        case .failure(_): break
        }
        
        return self
    }
    
    @discardableResult
    func onFailure(closure: (Failure) -> Void) -> Result<Success, Failure>{
        switch self {
        case .success(_): break
        case .failure(let failure):
            closure(failure)
        }
        
        return self
    }
    
    func isSuccesful() -> Bool{
        let isSuccessul: Bool
        switch self {
        case .success(_):
            isSuccessul = true
        case .failure(_):
            isSuccessul = false
        }
        
        return isSuccessul
    }
}
