//
//  TrendingLocalCoreDataDao.swift
//  Trending
//
//  Created by Farid Mammadov on 24.12.22.
//

import Foundation
import GRDB

class TrendingLocalGRDBDao: TrendingLocalDao{
    private let db: Database
    
    init(db: Database) {
        self.db = db
    }
    
    func get(query: GetTrendingQuery) -> TrendingResult<TrendingLocalEntity> {
        switch(query){
        case .getAllTrendginQuery: return getAllTrendingData()
        }
    }
    
    func put(query: GetTrendingQuery, data: [TrendingLocalEntity]) -> TrendingResult<TrendingLocalEntity> {
        switch(query){
        case .getAllTrendginQuery: return putAllTrendingData(data)
        }
    }
    
    private func getAllTrendingData() -> TrendingResult<TrendingLocalEntity>{
        let result: [TrendingOwnerEntity] = TrendingLocalEntity
            .including(required: TrendingLocalEntity.owner)
            .asRequest(of: TrendingOwnerEntity.self)
            .fetchAllOrFail(db)
        
        let trendingList = result.map { trendingOwner in
            let trending = trendingOwner.trending
            trending.owner = trendingOwner.owner
            return trending
        }
        
        return Result.success(trendingList)
    }
    
    private func putAllTrendingData(_ data: [TrendingLocalEntity]) -> TrendingResult<TrendingLocalEntity> {
        fatalError()
//        TrendingLocalEntity.deleteAll(db)
//
//        data.forEach { i in
//            i.insert(<#T##db: Database##Database#>)
//        }
    }
}
