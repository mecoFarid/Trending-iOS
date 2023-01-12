//
//  MockTrendingRepository.swift
//  Trending
//
//  Created by Farid Mammadov on 09.01.23.
//

import Foundation

class MockTrendingRepository<T, E: DataException>: Repository{
    
    private var result: () async -> Result<T, E>
    
    init(result: @escaping () async ->  Result<T, E>) {
        self.result = result
    }
    
    func get(query: Query, operation: Operation) async -> Result<T, E> {
        return await result()
    }
}
