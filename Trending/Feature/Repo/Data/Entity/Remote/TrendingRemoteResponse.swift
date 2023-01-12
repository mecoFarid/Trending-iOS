//
//  TrendingRemoteResponse.swift
//  Trending
//
//  Created by Farid Mammadov on 30.12.22.
//

import Foundation

struct TrendingRemoteResponse : Decodable{
    let items: [TrendingRemoteEntity]
}
