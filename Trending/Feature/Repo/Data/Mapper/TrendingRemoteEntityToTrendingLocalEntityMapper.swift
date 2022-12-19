//
//  RemoteTrendingEntityToLocalTrendingEntityMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation

class TrendingRemoteEntityToTrendingLocalEntityMapper<M: Mapper>: Mapper where M.I == OwnerRemoteEntity, M.O == OwnerLocalEntity{
    private let ownerMapper: M
    
    init(ownerMapper: M) {
        self.ownerMapper = ownerMapper
    }
    
    func map(i: TrendingRemoteEntity) -> TrendingLocalEntity {
        return TrendingLocalEntity(
            name: i.name,
            language: i.language,
            stargazers_count: i.stargazers_count,
            description: i.description,
            owner: ownerMapper.map(i: i.owner)
        )
    }
}

class OwnerRemoteEntityToOwnerLocalEntityMapper: Mapper{
    
    func map(i: OwnerRemoteEntity) -> OwnerLocalEntity {
        return OwnerLocalEntity(
            login: i.login, avatar_url: i.avatar_url
        )
    }
}
