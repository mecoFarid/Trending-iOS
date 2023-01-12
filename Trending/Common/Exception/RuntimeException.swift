//
//  RuntimeException.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
class RuntimeException: LocalizedError, Equatable{
    
    var errorDescription: String?
    
    init(_ errorDescription: String? = nil) {
        self.errorDescription = errorDescription
    }
    
    static func == (lhs: RuntimeException, rhs: RuntimeException) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}

extension RuntimeException{
    static func notImplemented(_ error: String = String()) -> Never{
        fatalError(error)
    }
}
