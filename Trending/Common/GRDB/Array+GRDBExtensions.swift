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
    func safeInsertAll(_ db: Database, option: MultipleInsertOptions = MultipleInsertOptions()) -> Bool{
        var success: Bool = true
        do {
            try db.inTransaction{
                try forEach { entity in
                    try entity.insert(db)
                }
                return .commit
            }
        }catch{
            success = false
        }
        
        return success
    }
}

class MultipleInsertOptions{
    init() {}
}
