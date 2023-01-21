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
        
        let mainOutMapper = ListMapper(TrendingRemoteEntityToTrendingMapper(OwnerRemoteEntityToOwnerMapper()))
        let cacheOutMapper = ListMapper(TrendingLocalEntityToTrendingMapper(OwnerLocalEntityToOwnerMapper()))
        let cacheInMapper = ListMapper(TrendingToTrendingLocalEntityMapper(OwnerToOwnerLocalEntityMapper()))
        
        let mainDatasource = DatasourceMapper(
            TrendingRemoteDatasource(networkComponent.getTrendingService()),
            outMapper: mainOutMapper,
            inMapper: VoidMapper()
        )
        
        let cacheDatasource = DatasourceMapper(
            TrendingLocalDatasource(databaseComponent.getTrendingDao()),
            outMapper: cacheOutMapper,
            inMapper: cacheInMapper
        )
        
        let repository = TrendingRepository(mainDataSource: mainDatasource, cacheDataSource: cacheDatasource)
        return GetTrendingInteractor(repository)
    }
}
