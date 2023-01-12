//
//  RepoRemoteDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
import Alamofire

class TrendingRemoteDatasource: Datasource{
    private let session: Session
    
    private let getTreandingOptions = RequestOptions(path: "search/repositories", parameters: ["q": "language=+sort:stars"])
    
    init(_ session: Session) {
        self.session = session
    }
    
    func get(query: Query) async -> TrendingResult<TrendingRemoteEntity> {
        let query: GetTrendingQuery = query.asSpecificQuery()
        switch query{
        case .getAllTrendginQuery:
            return await getAllTrendingData()
        }
    }
    
    func put(query: Query, data: [TrendingRemoteEntity]) async -> TrendingResult<TrendingRemoteEntity> {
        fatalError("Put not supported")
    }
    
    private func getAllTrendingData() async -> TrendingResult<TrendingRemoteEntity> {
        let request = BaseRouter.GET(requestOptions: getTreandingOptions)
        let result: Result<TrendingRemoteResponse, DataException> =  await session.executeRequest(request)
        return result.map { response in
            response.items
        }
    }
}
