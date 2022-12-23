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
    
    @NSManaged public var name: String
    @NSManaged public var language: String?
    @NSManaged public var stargazers_count: Int
    @NSManaged public var description_text: String?
    @NSManaged public var owner: OwnerLocalEntity
    
    
    init(
        context: NSManagedObjectContext,
        name: String,
        language: String?,
        stargazers_count: Int,
        description_text: String?,
        owner: OwnerLocalEntity
    ){
        super.init(entity: NSEntityDescription.entity(forEntityName: "TrendingLocalEntity", in: context)!, insertInto: context)
        self.description_text = description_text
        self.language = language
        self.name = name
        self.stargazers_count = stargazers_count
        self.owner = owner
    }
}

@objc(OwnerLocalEntity)
public class OwnerLocalEntity: NSManagedObject{
    
    @NSManaged public var login: String
    @NSManaged public var avatar_url: String?
    
    init(
        context: NSManagedObjectContext,
        login: String,
        avatar_url: String?
    ) {
        super.init(entity: NSEntityDescription.entity(forEntityName: "OwnerLocalEntity", in: context)!, insertInto: context)
        self.login = login
        self.avatar_url = avatar_url
    }
}
