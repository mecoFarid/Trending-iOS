//
//  LocalTrendingEntityToTrendingEntityMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation

class TrendingLocalEntityToTrendingMapper: Mapper{
    private let ownerMapper: any Mapper<OwnerLocalEntity, Owner>
    
    init(_ ownerMapper: any Mapper<OwnerLocalEntity, Owner>) {
        self.ownerMapper = ownerMapper
    }
    
    func map(_ i: TrendingLocalEntity) -> Trending {
        return Trending(
            trendingId: i.id,
            name: i.name,
            language: i.language,
            stargazersCount: i.stargazersCount,
            description: i.description,
            owner: ownerMapper.map(i.owner)
        )
    }
}

class OwnerLocalEntityToOwnerMapper: Mapper{
    
    func map(_ i: OwnerLocalEntity) -> Owner {
        return Owner(
            login: i.login, avatarUrl: i.avatarUrl
        )
    }
}
