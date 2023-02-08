//
//  TrendingLocalDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

class TrendingLocalDatasource: Datasource{
    
    private let trendinLocalDao: TrendingDao
    
    init(_ trendinLocalDao: TrendingDao) {
        self.trendinLocalDao = trendinLocalDao
    }
    
    func get(query: Query) async -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        var result = await trendinLocalDao.get(query: query)
        
        result.onSuccess { success in
            if success.isEmpty{
                result = Result.failure(DataException.DataNotFoundException("Data is empty"))
            }
        }
        return result
    }
    
    func put(query: Query, data: [TrendingLocalEntity]) async -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        return await trendinLocalDao.put(query: query, data: data)
    }
}
