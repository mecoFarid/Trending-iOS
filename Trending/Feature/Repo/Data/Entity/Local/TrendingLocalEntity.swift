//
//  TrendingLocalEntity.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
struct TrendingLocalEntity{
    let name: String
    let language: String?
    let stargazers_count: Int
    let description: String?
    let owner: OwnerLocalEntity
    
    init(name: String, language: String?, stargazers_count: Int, description: String?, owner: OwnerLocalEntity) {
        self.name = name
        self.language = language
        self.stargazers_count = stargazers_count
        self.description = description
        self.owner = owner
    }
}

struct OwnerLocalEntity{
    let login: String
    let avatar_url: String?
    
    init(login: String, avatar_url: String?) {
        self.login = login
        self.avatar_url = avatar_url
    }
}
