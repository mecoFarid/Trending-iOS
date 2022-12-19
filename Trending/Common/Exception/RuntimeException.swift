//
//  RuntimeException.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
class RuntimeException: LocalizedError{
    
    var errorDescription: String?
    
    fileprivate init(errorDescription: String? = nil) {
        self.errorDescription = errorDescription
    }
    
    class UnsupportedException: RuntimeException{
        override init(errorDescription: String? = nil) {
            super.init(errorDescription: errorDescription)
        }
    }
}
