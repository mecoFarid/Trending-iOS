//
//  GetTrendingInteractor.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
class GetTrendingInteractor<R: Repository> where R.T == [Trending], R.E == DataException{
    let repository: R
    
    init(repository: R) {
        self.repository = repository
    }
    
    func execute(query: GetTrendingQuery, operation: Operation) -> TrendingResult<Trending>{
        return repository.get(query: query, operation: operation)
    }
}
