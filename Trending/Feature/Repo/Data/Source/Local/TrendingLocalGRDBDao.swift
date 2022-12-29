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
        case .getAllTrendginQuery: putAllTrendingData(data)
        }
        return getAllTrendingData()
    }
    
    private func getAllTrendingData() -> TrendingResult<TrendingLocalEntity>{
        let result: Result<[TrendingOwnerEntity], DataException> = TrendingLocalEntity
            .including(required: TrendingLocalEntity.owner)
            .asRequest(of: TrendingOwnerEntity.self)
            .fetchAllOrFail(db)
        
        return result.map { succes in
            let trendingList = succes.map { trendingOwner in
                let trending = trendingOwner.trending
                trending.owner = trendingOwner.owner
                return trending
            }
            return trendingList
        }
    }
    
    private func putAllTrendingData(_ data: [TrendingLocalEntity]){
        TrendingLocalEntity.safeDeleteAll(db)
        data.safeInsertAll(db)
    }
}
