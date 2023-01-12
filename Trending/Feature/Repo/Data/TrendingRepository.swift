//
//  RepoRepository.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

typealias TrendingResult<T> = Result<[T], DataException>

class TrendingRepository: Repository{
    
    private let mainDataSource: any Datasource<[Trending], DataException>
    private let cacheDataSource: any Datasource<[Trending], DataException>
    
    init(mainDataSource: any Datasource<[Trending], DataException>, cacheDataSource: any Datasource<[Trending], DataException>) {
        self.mainDataSource = mainDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    
    func get(query: Query, operation: Operation) async -> TrendingResult<Trending> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        switch operation {
        case .mainElseCache:
            return await syncMain(query: query)
        case .cacheElseMain:
            let result = await getCache(query: query)
            if !result.isSuccesful(){
                return await get(query: query, operation: .mainElseCache)
            } else{
                return result
            }
        }
    }
    
    private func syncMain(query: GetTrendingQuery) async -> TrendingResult<Trending>{
        await mainDataSource.get(query: query).onSuccess { success in
            _ = await cacheDataSource.put(query: query, data: success)
        }
        return await getCache(query: query)
    }
    
    private func getCache(query: GetTrendingQuery) async -> TrendingResult<Trending>{
        return await cacheDataSource.get(query: query)
    }
}
