//
//  TrendingLocalDao.swift
//  Trending
//
//  Created by Farid Mammadov on 21.01.23.
//

import Foundation
import GRDB

class TrendingDao{
    
    private let db: DatabaseWriter
    
    init(_ db: DatabaseWriter) {
        self.db = db
    }
    
    func get(query: GetTrendingQuery) async -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        var result: TrendingResult<TrendingLocalEntity>
        switch(query){
        case .getAllTrendginQuery:
            result = await getAllTrendingData()
        }
        return result
    }
    
    func put(query: GetTrendingQuery, data: [TrendingLocalEntity]) async -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        switch(query){
        case .getAllTrendginQuery: return await putAllTrendingData(data)
        }
    }
    
    private func getAllTrendingData() async -> TrendingResult<TrendingLocalEntity>{
        let result: Result<[TrendingOwnerEntity], DataException> = await TrendingLocalEntity
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
    
    private func putAllTrendingData(_ data: [TrendingLocalEntity]) async -> TrendingResult<TrendingLocalEntity> {
        await TrendingLocalEntity.safeDeleteAll(db)
        let ownerList = data.compactMap{ trending in
            trending.owner
        }
        let trendinInserted = await data.safeInsertAll(db).isSuccesful()
        let ownerInserted = await ownerList.safeInsertAll(db).isSuccesful()
        if trendinInserted && ownerInserted{
            return Result.success(data)
        }else{
            return Result.failure(DataException("Failed to insert"))
        }
    }
}
