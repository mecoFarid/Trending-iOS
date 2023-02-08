//
//  TrendingProvider.swift
//  Trending
//
//  Created by Farid Mammadov on 09.01.23.
//

import Foundation
import GRDB
import Alamofire

protocol TrendingComponent{
    func getTrendingInteractor() -> GetTrendingInteractor
}

class TrendingModule: TrendingComponent{
    
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
            NetworkDatasource(
                service: networkComponent.getTrendingService(),
                exceptionMapper: NetworkExceptionMapper()
            ),
            outMapper: mainOutMapper,
            inMapper: VoidMapper()
        )
        
        let cacheDatasource = DatasourceMapper(
            TrendingLocalDatasource(databaseComponent.getTrendingDao()),
            outMapper: cacheOutMapper,
            inMapper: cacheInMapper
        )
        
        let repository = CacheRepository(mainDataSource: mainDatasource, cacheDataSource: cacheDatasource)
        return GetTrendingInteractor(repository)
    }
}

class NetworkExceptionMapper: Mapper{
    func map(_ i: NetworkException) -> DataException {
        return DataException.DataNotFoundException()
    }
}
