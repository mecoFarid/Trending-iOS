//
//  TrendingObjectMother.swift
//  TrendingTests
//
//  Created by Farid Mammadov on 19.12.22.
//

import Foundation
@testable import Trending

func randomTrending() -> Trending{
    return Trending(
        name: randomString(),
        language: randomNullable(){ randomString() },
        stargazersCount: randomInt(),
        description: randomNullable(){ randomString() },
        owner: randomTrendingOwner())
}

func randomTrendingOwner() -> Owner{
    return Owner(login: randomString(), avatarUrl: randomString())
}
