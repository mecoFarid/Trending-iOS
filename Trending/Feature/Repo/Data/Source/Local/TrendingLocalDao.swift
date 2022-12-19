//
//  TrendingLocalDao.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
protocol TrendingLocalDao{
    func get(query: GetTrendingQuery) -> TrendingResult<TrendingLocalEntity>
    func put(query: GetTrendingQuery, data: [TrendingLocalEntity]) -> TrendingResult<TrendingLocalEntity>
}
