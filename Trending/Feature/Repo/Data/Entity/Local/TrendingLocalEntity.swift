//
//  TrendingLocalEntity.swift
//  Trending
//
//  Created by Farid Mammadov on 23.12.22.
//

import Foundation
import GRDB

class TrendingLocalEntity: BaseRecord, Decodable{
    override class var databaseTableName: String { "TrendingLocalEntity" }
    var name: String
    var language: String?
    var stargazersCount: Int
    var description: String?
    static let owner = hasOne(
        OwnerLocalEntity.self,
        key: TrendingLocalEntity.id.name,
        using: ForeignKey(
            [TrendingLocalEntity.id.name],
            to: [OwnerLocalEntity.id.name]
        )
    ).forKey(TrendingOwnerEntity.owner)
    var owner: OwnerLocalEntity!
    
    init(
        id: Int,
        name: String,
        language: String?,
        stargazersCount: Int,
        description: String?,
        owner: OwnerLocalEntity
    ){
        self.description = description
        self.language = language
        self.name = name
        self.stargazersCount = stargazersCount
        self.owner = owner
        super.init(id: id)
    }
    
    required init(row: Row) throws {
        name = row[TrendingLocalEntity.name]
        language = row[TrendingLocalEntity.language]
        stargazersCount = row[TrendingLocalEntity.stargazersCount]
        description = row[TrendingLocalEntity.description]
        try super.init(row: row)
        id = row[TrendingLocalEntity.name]
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[TrendingLocalEntity.name] = name
        container[TrendingLocalEntity.language] = language
        container[TrendingLocalEntity.stargazersCount] = stargazersCount
        container[TrendingLocalEntity.description] = description
        container[TrendingLocalEntity.name] = id
    }
}

extension TrendingLocalEntity{
    static let name = Column("name")
    static let language = Column("language")
    static let stargazersCount = Column("stargazersCount")
    static let description = Column("description")
}

class OwnerLocalEntity: BaseRecord, Decodable{
    
    override class var databaseTableName: String { "OwnerLocalEntity" }
    
    var login: String
    var avatarUrl: String?
    
    init(
        login: String,
        avatarUrl: String?
    ) {
        self.login = login
        self.avatarUrl = avatarUrl
        super.init()
    }
    
    required init(row: Row) throws {
        login = row[OwnerLocalEntity.login]
        avatarUrl = row[OwnerLocalEntity.avatarUrl]
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[OwnerLocalEntity.login] = login
        container[OwnerLocalEntity.avatarUrl] = avatarUrl
    }
}

extension OwnerLocalEntity{
    static let login = "login"
    static let avatarUrl = "avatarUrl"
}


struct TrendingOwnerEntity: FetchableRecord, Decodable{
    var trending: TrendingLocalEntity
    var owner: OwnerLocalEntity
}

extension TrendingOwnerEntity{
    static let owner = "owner"
}
