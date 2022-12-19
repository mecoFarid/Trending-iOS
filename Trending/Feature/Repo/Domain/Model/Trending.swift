//
//  Trending.swift
//  Trending
//
//  Created by Farid Mammadov on 02.12.22.
//

import Foundation
struct Trending: Equatable{
    
    let name: String
    let language: String?
    let stargazersCount: Int
    let description: String?
    let owner: Owner
    
    init(name: String, language: String?, stargazersCount: Int, description: String?, owner: Owner) {
        self.name = name
        self.language = language
        self.stargazersCount = stargazersCount
        self.description = description
        self.owner = owner
    }

    
    static func == (lhs: Trending, rhs: Trending) -> Bool {
        return lhs.name == rhs.name
        && lhs.language == rhs.language
        && lhs.stargazersCount == rhs.stargazersCount
        && lhs.description == rhs.description
        && lhs.owner == rhs.owner
    }
}

struct Owner: Equatable{
    let login: String
    let avatarUrl: String?
    
    init(login: String, avatarUrl: String?) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
    
    static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.login == rhs.login
        && lhs.avatarUrl == rhs.avatarUrl
    }
}
