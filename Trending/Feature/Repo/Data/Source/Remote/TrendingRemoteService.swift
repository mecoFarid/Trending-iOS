//
//  TrendingRemoteService.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
protocol TrendingRemoteService{
    func get(query: GetTrendingQuery) -> TrendingResult<TrendingRemoteEntity>
}
