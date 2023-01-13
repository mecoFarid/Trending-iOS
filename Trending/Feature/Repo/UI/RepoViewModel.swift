//
//  RepoViewModel.swift
//  Trending
//
//  Created by Farid Mammadov on 05.01.23.
//

import Foundation

@MainActor
class RepoViewModel: ObservableObject{
    
    @Published private(set) var uiState: UiState = .loading
    private var task: Task<TrendingResult<Trending>, Never>?
    
    let getTrendingInteractor: GetTrendingInteractor
    
    init(_ getTrendingInteractor: GetTrendingInteractor) {
        self.getTrendingInteractor = getTrendingInteractor
    }
    
    deinit {
        task?.cancel()
    }
    
    func loadData(){
        loadData(.cacheElseMain)
    }
    
    func refreshData(){
        if case .loading = uiState {
            return
        }
        loadData(.mainElseCache)
    }
    
    private func loadData(_ operation: Operation) {
        uiState = .loading
        cancel()
        task = Task{
            await getTrendingInteractor.execute(
                query: .getAllTrendginQuery,
                operation: operation
            ).onSuccess{ data in
                uiState = .success(data)
            }
            .onFailure{ _ in
                uiState = .error
            }
        }
    }
    
    func cancel(){
        task?.cancel()
    }
}

enum UiState{
    case loading, success([Trending]), error
}
