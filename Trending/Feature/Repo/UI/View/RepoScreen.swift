//
//  RepoView.swift
//  Trending
//
//  Created by Farid Mammadov on 05.01.23.
//

import SwiftUI

struct RepoScreen: View {
    
    @EnvironmentObject var viewModel: RepoViewModel
    
    var body: some View {
        VStack{
            switch viewModel.uiState {
            case .success(let data):
                RepoList(trendingList: data)
            case .loading:
                LottieView(name: LottieAnimation.loading.rawValue)
                    .frame(width: Dimens.gu_30.rawValue, height: Dimens.gu_30.rawValue)
            case .error:
                LottieView(name: LottieAnimation.noData.rawValue)
                    .frame(width: Dimens.gu_30.rawValue, height: Dimens.gu_30.rawValue)
            }
        }
        .onAppear{
            viewModel.loadData(operation: .cacheElseMain)
        }
        .onDisappear{
            viewModel.cancel()
        }
    }
}

struct RepoList: View {
    
    let trendingList: [Trending]
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(trendingList) { trending in
                    RepoItem(trending: trending)
                    Divider()
                }
            }
        }
        .padding()
    }
}

struct RepoScreen_Previews: PreviewProvider {
    static let interactor = GetTrendingInteractor(
        MockTrendingRepository{
            sleep(1_000)
            return Result.success([anyTrending()])
        }
    )
    static var previews: some View {
        RepoScreen().environmentObject(RepoViewModel(interactor))
    }
}
