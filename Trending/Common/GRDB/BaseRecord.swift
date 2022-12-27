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
}

extension BaseRecord{
    static let id = Column("id")
}
