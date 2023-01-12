//
//  RepoProvider.swift
//  Trending
//
//  Created by Farid Mammadov on 09.01.23.
//

import Foundation
import GRDB
import Alamofire

protocol RepoComponent{
    func getTrendingInteractor() -> GetTrendingInteractor
}

class RepoModule: RepoComponent{
    
    private let databaseComponent: DatabaseComponent
    private let networkComponent: NetworkComponent
    
    init(_ databaseComponent: DatabaseComponent, _ networkComponent: NetworkComponent) {
        self.databaseComponent = databaseComponent
        self.networkComponent = networkComponent
    }
    
    func getTrendingInteractor() -> GetTrendingInteractor {
        
        var mainOutMapper = ListMapper(TrendingRemoteEntityToTrendingMapper(OwnerRemoteEntityToOwnerMapper()))
        var cacheOutMapper = ListMapper(TrendingLocalEntityToTrendingMapper(OwnerLocalEntityToOwnerMapper()))
        var cacheInMapper = ListMapper(TrendingToTrendingLocalEntityMapper(OwnerToOwnerLocalEntityMapper()))
        
        let mainDatasource = DatasourceMapper(
            TrendingRemoteDatasource(networkComponent.getSesssion()),
            outMapper: mainOutMapper,
            inMapper: VoidMapper()
        )
        
        let cacheDatasource = DatasourceMapper(
            TrendingLocalDatasource(databaseComponent.getDatabase()),
            outMapper: cacheOutMapper,
            inMapper: cacheInMapper
        )
        
        let repository = TrendingRepository(mainDataSource: mainDatasource, cacheDataSource: cacheDatasource)
        return GetTrendingInteractor(repository)
    }
}
