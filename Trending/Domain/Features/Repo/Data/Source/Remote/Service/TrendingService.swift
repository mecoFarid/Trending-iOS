//
//  TrendingService.swift
//  Trending
//
//  Created by Farid Mammadov on 21.01.23.
//

import Foundation
import Alamofire

class TrendingService{
    
    private let session: Session
    
    init(_ session: Session) {
        self.session = session
    }
    
    func get(query: GetTrendingQuery) async -> TrendingResult<TrendingRemoteEntity> {
        return await getAllTrendingData(query.toRequestOptions())
    }
    
    private func getAllTrendingData(_ options: RequestOptions) async -> TrendingResult<TrendingRemoteEntity> {
        let request = BaseRouter.GET(requestOptions: options)
        let result: Result<TrendingRemoteResponse, DataException> =  await session.executeRequest(request)
        return result.map { response in
            response.items
        }
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
