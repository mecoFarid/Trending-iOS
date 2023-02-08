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
    static func safeDeleteAll(_ dbWriter: DatabaseWriter, option: MultipleDeleteOptions = MultipleDeleteOptions()) async -> Result<Int, DataException>{
        return await withCheckedContinuation{ continuation in
            let result = safeOrFail{
                var count = 0
                try dbWriter.write{ db in
                    count = try deleteAll(db)
                }
                return count
            }
            
            continuation.resume(returning: result)
        }
    }
}

actor Count{
    var count: Int = 0
    
    func setCount(_ count: Int){
        self.count = count
    }
}

extension BaseRecord{
    static let id = Column("id")
}

class MultipleDeleteOptions{
    init() {}
}
