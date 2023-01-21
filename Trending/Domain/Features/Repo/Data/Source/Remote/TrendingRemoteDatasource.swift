//
//  RepoRemoteDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
class TrendingRemoteDatasource: Datasource{
    private let service: TrendingService
    
    init(_ service: TrendingService) {
        self.service = service
    }
    
    func get(query: Query) async -> TrendingResult<TrendingRemoteEntity> {
        return await service.get(query: query.asSpecificQuery())
    }
    
    func put(query: Query, data: [TrendingRemoteEntity]) async -> TrendingResult<TrendingRemoteEntity> {
        fatalError("Put not supported")
    }
}
