//
//  RepoLocalDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

class TrendingLocalDatasource: Datasource{
    
    private let trendingLocalDao: TrendingLocalDao
    
    init(trendingLocalDao: TrendingLocalDao) {
        self.trendingLocalDao = trendingLocalDao
    }
    
    func get(query: Query) -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        return query.get(trendingLocalDao: trendingLocalDao)
    }
    
    func put(query: Query, data: [TrendingLocalEntity]) -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        return query.put(trendingLocalDao: trendingLocalDao, data: data)
    }
}

extension GetTrendingQuery{
    func get(trendingLocalDao: TrendingLocalDao) -> TrendingResult<TrendingLocalEntity>{
        switch self {
        case .getAllTrendginQuery:
            var result: TrendingResult<TrendingLocalEntity> = trendingLocalDao.get(query: self)
            _ = result.onSuccess { success in
                if success.isEmpty{
                    result = Result.failure(DataException.DataNotFoundException(errorDescription: "Data is empty"))
                }
            }
            return result
        }
    }
    
    func put(trendingLocalDao: TrendingLocalDao, data: [TrendingLocalEntity]) -> TrendingResult<TrendingLocalEntity>{
        switch self {
        case .getAllTrendginQuery:
            return trendingLocalDao.put(query: self, data: data)
        }
    }
}
