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
    func safeInsertAll(_ dbWriter: DatabaseWriter, option: MultipleInsertOptions = MultipleInsertOptions()) async -> Result<Bool, DataException>{
        await safeOrFail{
            try await dbWriter.write{ db in
                try forEach { entity in
                    try entity.insert(db)
                }
            }
            return true
        }
    }
}

class MultipleInsertOptions{
    init() {}
}
