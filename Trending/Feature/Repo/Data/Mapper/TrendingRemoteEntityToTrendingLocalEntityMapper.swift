//
//  RemoteTrendingEntityToLocalTrendingEntityMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
import CoreData

class TrendingRemoteEntityToTrendingLocalEntityMapper<M: Mapper>: Mapper where M.I == OwnerRemoteEntity, M.O == OwnerLocalEntity{
    private let ownerMapper: M
    private let nsManagedObjectContext: NSManagedObjectContext
    
    init(ownerMapper: M, nsManagedObjectContext: NSManagedObjectContext) {
        self.ownerMapper = ownerMapper
        self.nsManagedObjectContext = nsManagedObjectContext
    }
    
    func map(i: TrendingRemoteEntity) -> TrendingLocalEntity {
        return TrendingLocalEntity(
            context: nsManagedObjectContext,
            name: i.name,
            language: i.language,
            stargazers_count: i.stargazers_count,
            description_text: i.description,
            owner: ownerMapper.map(i: i.owner)
        )
    }
}

class OwnerRemoteEntityToOwnerLocalEntityMapper: Mapper{
    
    private let nsManagedObjectContext: NSManagedObjectContext
    
    init(nsManagedObjectContext: NSManagedObjectContext) {
        self.nsManagedObjectContext = nsManagedObjectContext
    }
    
    func map(i: OwnerRemoteEntity) -> OwnerLocalEntity {
        return OwnerLocalEntity(
            context: nsManagedObjectContext,
            login: i.login,
            avatar_url: i.avatar_url
        )
    }
}
