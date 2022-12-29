//
//  Arrays+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 27.12.22.
//

import Foundation
import GRDB

extension Array where Element: PersistableRecord{
    
    @discardableResult
    func safeInsertAll(_ db: Database, option: MultipleInsertOptions = MultipleInsertOptions()) -> Result<Bool, DataException>{
       safeOrFail{
           try db.inTransaction{
               try forEach { entity in
                   try entity.insert(db)
               }
               return .commit
           }
           return true
       }
    }
}

class MultipleInsertOptions{
    init() {}
}
