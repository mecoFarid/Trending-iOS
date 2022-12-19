//
//  DataException.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
class DataException: LocalizedError, Equatable{

    var errorDescription: String?
    
    fileprivate init(errorDescription: String? = nil) {
        self.errorDescription = errorDescription
    }
    
    class DataNotFoundException: DataException{
        override init(errorDescription: String? = nil) {
            super.init(errorDescription: errorDescription)
        }
    }
    
    static func == (lhs: DataException, rhs: DataException) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}
