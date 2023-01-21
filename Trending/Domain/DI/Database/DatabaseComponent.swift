//
//  DatabaseComponent.swift
//  Trending
//
//  Created by Farid Mammadov on 11.01.23.
//

import Foundation

protocol DatabaseComponent{
    func getTrendingDao() -> TrendingDao
}
