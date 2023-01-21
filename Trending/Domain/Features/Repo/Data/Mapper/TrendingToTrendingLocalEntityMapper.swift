//
//  TrendingToTrendingLocalEntityMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 11.01.23.
//

import Foundation

class TrendingToTrendingLocalEntityMapper: Mapper{
    private let ownerMapper: any Mapper<Owner, OwnerLocalEntity>
    
    init(_ ownerMapper: any Mapper<Owner, OwnerLocalEntity>) {
        self.ownerMapper = ownerMapper
    }
    
    func map(_ i: Trending) -> TrendingLocalEntity {
        let owner = ownerMapper.map(i.owner)
        owner.trendingId = i.trendingId
        return TrendingLocalEntity(
            id: i.id,
            name: i.name,
            language: i.language,
            stargazersCount: i.stargazersCount,
            description: i.description,
            owner: owner
        )
    }
}

class OwnerToOwnerLocalEntityMapper: Mapper{
    
    func map(_ i: Owner) -> OwnerLocalEntity {
        return OwnerLocalEntity(
            login: i.login, avatarUrl: i.avatarUrl
        )
    }
}
