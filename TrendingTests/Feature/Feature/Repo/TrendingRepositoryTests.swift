//
//  TrendingRepositoryTests.swift
//  TrendingTests
//
//  Created by Farid Mammadov on 14.12.22.
//

import Foundation
@testable import Trending
import XCTest
import Cuckoo
import Nimble


final class TrendingRepositoryTests: XCTestCase{
    
    private let cacheDatasource = MockDatasource<[Trending], DataException>()
    private let mainDatasource = MockDatasource<[Trending], DataException>()
    private var repository: TrendingRepository<MockDatasource<[Trending], DataException>, MockDatasource<[Trending], DataException>>!
    
    override func setUp() {
        repository = TrendingRepository(mainDatasource, cacheDatasource)
    }
        
    func test_assert_main_datasource_synced_when_cache_datasource_does_not_have_data(){
        let trendingList = randomNumberOf(){ randomTrending() }
        let mainSuccessful = Result<[Trending], DataException>.success(trendingList)
        let expectedResult = Result<[Trending], DataException>.success(trendingList)
        let cacheFailure = Result<[Trending], DataException>.failure(DataException.DataNotFoundException())
        stub(cacheDatasource){ mock in
            when(mock.get(query: any())).thenReturn(cacheFailure, expectedResult)
            when(mock.put(query: any(), data: any())).thenReturn(expectedResult)
        }
        stub(mainDatasource){ mock in
            when(mock.get(query: any())).thenReturn(mainSuccessful)
        }
        
        let actualResult = repository.get(query: GetTrendingQuery.getAllTrendginQuery, operation: Operation.cacheElseMain)
        
        verify(cacheDatasource, times(2)).get(query: any())
        verify(cacheDatasource).put(query: any(), data: mainSuccessful)
        verify(mainDatasource).get(query: any())
        expect(actualResult).to(equal(expectedResult))
    }
    
    func test_assert_data_fetched_from_cache_datasource_when_data_exists(){
        let trendingList = randomNumberOf(){ randomTrending() }
        let mainSuccessful = Result<[Trending], DataException>.success(trendingList)
        let expectedResult = Result<[Trending], DataException>.success(trendingList)
        stub(cacheDatasource){ mock in
            when(mock.get(query: any())).thenReturn(expectedResult)
        }
        
        let actualResult = repository.get(query: GetTrendingQuery.getAllTrendginQuery, operation: Operation.cacheElseMain)
        
        verify(cacheDatasource).get(query: any())
        verify(cacheDatasource, times(0)).put(query: any(), data: mainSuccessful)
        verify(mainDatasource, times(0)).get(query: any())
        expect(actualResult).to(equal(expectedResult))
    }
}
