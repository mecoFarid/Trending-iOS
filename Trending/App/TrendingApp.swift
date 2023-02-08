//
//  TrendingApp.swift
//  Trending
//
//  Created by Farid Mammadov on 05.01.23.
//

import SwiftUI

private var appComponent: AppComponent = { AppModule() }()

@main
struct TrendingApp: App {

    var body: some Scene {
        WindowGroup{
            TreningScreen().environmentObject(TrendingViewModel(appComponent.getTrendingComponent().getTrendingInteractor()))
        }
    }
}
