//
//  RepoRepository.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

typealias TrendingResult<T> = Result<[T], DataException>

class TrendingRepository<MD: Datasource, CD: Datasource>:
    Repository where MD.T == [Trending], MD.E == DataException,
                     CD.T == [Trending], CD.E == DataException {
    
    private let mainDataSource: MD
    private let cacheDataSource: CD
    
    init(_ mainDataSource: MD, _ cacheDataSource: CD) {
        self.mainDataSource = mainDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    
    func get(query: Query, operation: Operation) -> TrendingResult<Trending> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        switch operation {
        case .mainElseCache:
            return syncMain(query: query)
        case .cacheElseMain:
            let result = getCache(query: query)
            if !result.isSuccesful(){
                return get(query: query, operation: .mainElseCache)
            } else{
                return result
            }
        }
    }
    
    private func syncMain(query: GetTrendingQuery) -> TrendingResult<Trending>{
        mainDataSource.get(query: query).onSuccess { success in
            _ = cacheDataSource.put(query: query, data: success)
        }
        return getCache(query: query)
    }
    
    private func getCache(query: GetTrendingQuery) -> TrendingResult<Trending>{
        return cacheDataSource.get(query: query)
    }
}
