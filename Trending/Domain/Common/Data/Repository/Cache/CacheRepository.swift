//
//  CacheRepository.swift
//  Trending
//
//  Created by Farid Mammadov on 08.02.23.
//

import Foundation

class CacheRepository<Main, Cache, T, E>:
    Repository where Main: Datasource, Cache: Datasource, Main.T == T, Main.E == E, Cache.T == T, Cache.E == E {
    
    private let mainDataSource: Main
    private let cacheDataSource: Cache
    
    init(mainDataSource: Main, cacheDataSource: Cache) {
        self.mainDataSource = mainDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    func get(query: Query, operation: Operation) async -> Result<T, E> {
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
    
    private func syncMain(query: GetTrendingQuery) async -> Result<T, E>{
        await mainDataSource.get(query: query).onSuccess { success in
            _ = await cacheDataSource.put(query: query, data: success)
        }
        return await getCache(query: query)
    }
    
    private func getCache(query: GetTrendingQuery) async -> Result<T, E>{
        return await cacheDataSource.get(query: query)
    }
}
