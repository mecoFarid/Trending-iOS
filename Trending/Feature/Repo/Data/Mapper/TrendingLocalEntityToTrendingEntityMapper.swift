//
//  LocalTrendingEntityToTrendingEntityMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation

class TrendingLocalEntityToTrendingLocalEntityMapper<M: Mapper>: Mapper where M.I == OwnerLocalEntity, M.O == Owner{
    private let ownerMapper: M
    
    init(ownerMapper: M) {
        self.ownerMapper = ownerMapper
    }
    
    func map(i: TrendingLocalEntity) -> Trending {
        return Trending(
            name: i.name!,
            language: i.language,
            stargazersCount: Int(i.stargazers_count),
            description: i.description,
            owner: ownerMapper.map(i: i.owner!)
        )
    }
}

class OwnerLocalEntityToOwnerMapper: Mapper{
    
    func map(i: OwnerLocalEntity) -> Owner {
        return Owner(
            login: i.login!, avatarUrl: i.avatar_url
        )
    }
}
