//
//  TreningScreen.swift
//  Trending
//
//  Created by Farid Mammadov on 05.01.23.
//

import SwiftUI

struct TreningScreen: View {
    
    @EnvironmentObject var viewModel: TrendingViewModel
    var uiState: UiState { viewModel.uiState }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack(alignment: .center){
                switch uiState {
                case .success(let data):
                    TrendingList(trendingList: data)
                case .loading:
                    LottieView(name: LottieAnimation.loading.rawValue)
                        .frame(width: Dimens.gu_30.rawValue, height: Dimens.gu_30.rawValue)
                case .error:
                    LottieView(name: LottieAnimation.noData.rawValue)
                        .frame(width: Dimens.gu_30.rawValue, height: Dimens.gu_30.rawValue)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if case .loading = uiState {} else {
                RefreshButton(viewModel: viewModel)
            }
        }
        .padding()
        .onAppear{
            viewModel.loadData()
        }
        .onDisappear{
            viewModel.cancel()
        }
    }
}

struct TrendingList: View {
    
    let trendingList: [Trending]
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(trendingList) { trending in
                    TrendingItem(trending: trending)
                    Divider()
                }
            }
            .padding([.bottom], Dimens.gu_6.rawValue)
        }
    }
}

struct RefreshButton: View{
    
    let viewModel: TrendingViewModel
    
    var body: some View{
        Button{
            viewModel.refreshData()
        } label: {
            Image(systemName: "goforward")
                .foregroundColor(Color.white)
                .frame(width: Dimens.gu_6.rawValue)
                .padding(.all, Dimens.gu.rawValue)
                .background(Color.orange)
                .clipShape(Circle())
        }
    }
}

struct TrendingScreen_Previews: PreviewProvider {
    static let interactor = GetTrendingInteractor(
        MockRepository{
            return Result.success([anyTrending()])
        }
    )
    static var previews: some View {
        TreningScreen().environmentObject(TrendingViewModel(interactor))
    }
}
