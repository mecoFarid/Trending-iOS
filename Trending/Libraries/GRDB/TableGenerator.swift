//
//  TableGenerator.swift
//  Trending
//
//  Created by Farid Mammadov on 11.01.23.
//

import Foundation
import GRDB

class TableGenerator{
    static func generatetables(_ dbWriter: DatabaseWriter){
        safeOrFail{
            try dbWriter.write{ db in
                try db.create(table: TrendingLocalEntity.databaseTableName, ifNotExists: true){ t in
                    t.primaryKey(TrendingLocalEntity.id.name, .integer)
                    t.column(TrendingLocalEntity.language.name, .text)
                    t.column(TrendingLocalEntity.name.name, .text).notNull()
                    t.column(TrendingLocalEntity.stargazersCount.name, .text).notNull()
                    t.column(TrendingLocalEntity.description.name, .text)
                }
                
                
                try db.create(table: OwnerLocalEntity.databaseTableName, ifNotExists: true){ t in
                    t.autoIncrementedPrimaryKey(OwnerLocalEntity.id.name)
                    t.column(OwnerLocalEntity.trendingId.name, .integer)
                    t.foreignKey([OwnerLocalEntity.trendingId.name], references: TrendingLocalEntity.databaseTableName)
                    t.column(OwnerLocalEntity.login.name, .text).notNull()
                    t.column(OwnerLocalEntity.avatarUrl.name, .text)
                }
            }
        }
    }
}
