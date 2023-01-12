//
//  TrendingApp.swift
//  Trending
//
//  Created by Farid Mammadov on 05.01.23.
//

import SwiftUI

private var appComponent: AppComponent = { AppComponent() }()

@main
struct TrendingApp: App {
    
    var body: some Scene {
        WindowGroup{
            RepoScreen().environmentObject(RepoViewModel(appComponent.getRepoComponent().getTrendingInteractor()))
        }
    }
}
