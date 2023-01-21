//
//  GetTrendingInteractor.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
class GetTrendingInteractor{
    let repository: any Repository<[Trending], DataException>

    init(_ repository: any Repository<[Trending], DataException>) {
        self.repository = repository
    }
    
    func execute(query: GetTrendingQuery, operation: Operation) async -> TrendingResult<Trending>{
        return await repository.get(query: query, operation: operation)
    }
}
