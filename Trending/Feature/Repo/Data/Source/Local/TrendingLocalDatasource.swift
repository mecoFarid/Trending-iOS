//
//  RepoLocalDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
import GRDB

class TrendingLocalDatasource: Datasource{
    
    private let db: DatabaseWriter
    
    init(_ db: DatabaseWriter) {
        self.db = db
    }
    
    func get(query: Query) async -> TrendingResult<TrendingLocalEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        var result: TrendingResult<TrendingLocalEntity>
        switch(query){
        case .getAllTrendginQuery:
            result = await getAllTrendingData()
        }
        
        result.onSuccess { success in
            if success.isEmpty{
                result = Result.failure(DataException.DataNotFoundException("Data is empty"))
            }
        }
        return result
    }
    
    func put(query: Query, data: [TrendingLocalEntity]) async -> TrendingResult<TrendingLocalEntity> {
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
        await OwnerLocalEntity.safeDeleteAll(db)
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
