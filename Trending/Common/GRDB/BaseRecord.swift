//
//  IdentifiableRecord.swift
//  Trending
//
//  Created by Farid Mammadov on 26.12.22.
//

import Foundation
import GRDB

open class BaseRecord: Record{
    var id: Int
    
    public override init(){
        id = 0
        super.init()
    }
    
    public init(id: Int) {
        self.id = id
        super.init()
    }
    
    public required init(row: Row) throws {
        id = row[BaseRecord.id]
        try super.init(row: row)
    }
    
    open override func encode(to container: inout PersistenceContainer) throws {
        container[BaseRecord.id] = id
    }
    
    @discardableResult
    static func safeDeleteAll(_ db: Database, option: MultipleDeleteOptions = MultipleDeleteOptions()) -> Result<Int, DataException>{
        return safeOrFail {
            var deletedCount: Int = 0
            try db.inTransaction{
                deletedCount = try deleteAll(db)
                return .commit
            }
            return deletedCount
        }
    }
}

extension BaseRecord{
    static let id = Column("id")
}

class MultipleDeleteOptions{
    init() {}
}
