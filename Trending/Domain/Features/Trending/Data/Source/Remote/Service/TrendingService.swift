//
//  TrendingService.swift
//  Trending
//
//  Created by Farid Mammadov on 21.01.23.
//

import Foundation
import Alamofire

class TrendingService: NetworkService{
    private let session: Session
    
    init(_ session: Session) {
        self.session = session
    }
    
    func get(query: Query) async throws -> [TrendingRemoteEntity] {
        return try await getAllTrendingData(query.asSpecificQuery())
    }
    
    func put(query: Query, data: [TrendingRemoteEntity]) async throws -> [TrendingRemoteEntity] {
        fatalError("Put not supported")
    }
    
    private func getAllTrendingData(_ query: GetTrendingQuery) async throws -> [TrendingRemoteEntity] {
        let request = BaseRouter.GET(requestOptions: query.toRequestOptions())
        let result: TrendingRemoteResponse = try await session.executeRequest(request)
        return result.items
    }
}

extension GetTrendingQuery{
    func toRequestOptions() -> RequestOptions{
        let options: RequestOptions
        switch self{
        case .getAllTrendginQuery(let query):
            options = RequestOptions(path: "search/repositories", parameters: ["q": query])
        }
        
        return options
    }
}
