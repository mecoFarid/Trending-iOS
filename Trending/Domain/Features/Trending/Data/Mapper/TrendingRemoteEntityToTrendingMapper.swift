//
//  RemoteTrendingEntityToLocalTrendingEntityMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
import CoreData

class TrendingRemoteEntityToTrendingMapper: Mapper{
    private let ownerMapper: any Mapper<OwnerRemoteEntity, Owner>
    
    init(_ ownerMapper: any Mapper<OwnerRemoteEntity, Owner>) {
        self.ownerMapper = ownerMapper
    }
    
    func map(_ i: TrendingRemoteEntity) -> Trending {
        return Trending(
            trendingId: i.id,
            name: i.name,
            language: i.language,
            stargazersCount: i.stargazers_count,
            description: i.description,
            owner: ownerMapper.map(i.owner)
        )
    }
}

class OwnerRemoteEntityToOwnerMapper: Mapper{
    
    func map(_ i: OwnerRemoteEntity) -> Owner {
        return Owner(
            login: i.login,
            avatarUrl: i.avatar_url
        )
    }
}
