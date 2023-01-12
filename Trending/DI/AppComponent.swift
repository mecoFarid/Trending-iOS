//
//  AppProvider.swift
//  Trending
//
//  Created by Farid Mammadov on 10.01.23.
//

import Foundation

class AppComponent{
    
    private lazy var session : NetworkComponent = {
        AlamofireModule()
    }()
    
    private lazy var db: DatabaseComponent = {
        GRDBModule()
    }()
    
    func getRepoComponent() -> RepoComponent{
        RepoModule(db, session)
    }
}
