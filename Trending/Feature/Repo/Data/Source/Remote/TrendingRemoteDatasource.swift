//
//  RepoRemoteDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

class TrendingRemoteDatasource: Datasource{
    private let service: TrendingRemoteService
    
    init(service: TrendingRemoteService) {
        self.service = service
    }
    
    func get(query: Query) -> TrendingResult<TrendingRemoteEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        return query.get(service: service)
    }
    
    func put(query: Query, data: [TrendingRemoteEntity]) -> TrendingResult<TrendingRemoteEntity> {
        fatalError("Put not supported")
    }
}

extension GetTrendingQuery{
    func get(service: TrendingRemoteService) -> TrendingResult<TrendingRemoteEntity>{
        switch self {
        case .getAllTrendginQuery:
            return service.get(query: self)
        }
    }
}
