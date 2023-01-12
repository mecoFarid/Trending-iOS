//
//  TrendingMocks.swift
//  Trending
//
//  Created by Farid Mammadov on 06.01.23.
//

import Foundation

func anyTrending() -> Trending{
    return Trending(trendingId: Int.random(in: Int.min...Int.max) ,name: "Name but very ", language: "Language", stargazersCount: 23, description: "Description but very loooooooooooooooooooooooooooooooooooooooooooooooooong   sjhgjhgdsjhgds", owner: anyOwner())
}

func anyOwner() -> Owner{
    return Owner(login: "Login but very ", avatarUrl: "Url")
}
