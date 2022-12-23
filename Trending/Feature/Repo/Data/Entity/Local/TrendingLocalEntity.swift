//
//  TrendingLocalEntity.swift
//  Trending
//
//  Created by Farid Mammadov on 23.12.22.
//

import Foundation
import CoreData

@objc(TrensingLocalEntity)
public class TrendingLocalEntity: NSManagedObject{
    
    static func initWithParams(
        context: NSManagedObjectContext,
        name: String,
        language: String?,
        stargazers_count: Int,
        description_text: String?,
        owner: OwnerLocalEntity
    ) -> TrendingLocalEntity {
        let entity = TrendingLocalEntity(context: context)
        entity.description_text = description_text
        entity.language = language
        entity.name = name
        entity.stargazers_count = Int64(stargazers_count)
        entity.owner = owner
        return entity
    }
}

@objc(OwnerLocalEntity)
public class OwnerLocalEntity: NSManagedObject{
    
    static func initWithParams(
        context: NSManagedObjectContext,
        login: String,
        avatar_url: String?
    ) -> OwnerLocalEntity {
        let entity = OwnerLocalEntity(context: context)
        entity.login = login
        entity.avatar_url = avatar_url
        return entity
    }
}
