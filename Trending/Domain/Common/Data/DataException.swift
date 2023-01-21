//
//  DataException.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
class DataException: RuntimeException{

    class DataNotFoundException: DataException{
        override init(_ errorDescription: String? = nil) {
            super.init(errorDescription)
        }
    }
}
