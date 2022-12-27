//
//  TrendingRemoteEntity.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
struct TrendingRemoteEntity{
    let id: Int
    let name: String
    let language: String?
    let stargazers_count: Int
    let description: String?
    let owner: OwnerRemoteEntity
    
    init(id: Int, name: String, language: String?, stargazers_count: Int, description: String?, owner: OwnerRemoteEntity) {
        self.id = id
        self.name = name
        self.language = language
        self.stargazers_count = stargazers_count
        self.description = description
        self.owner = owner
    }
    
}

struct OwnerRemoteEntity{
       let login: String
       let avatar_url: String?
       
       init(login: String, avatar_url: String?) {
           self.login = login
           self.avatar_url = avatar_url
       }
   }
