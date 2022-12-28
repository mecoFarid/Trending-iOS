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
    private var repository: TrendingRepository!
    
    override func setUp() {
        repository = TrendingRepository(mainDatasource, cacheDatasource)
    }
        
    func test_assert_main_datasource_synced_when_cache_datasource_does_not_have_data(){
        let query = GetTrendingQuery.getAllTrendginQuery
        let trendingList = randomNumberOf(){ randomTrending() }
        let mainSuccessful = Result<[Trending], DataException>.success(trendingList)
        let expectedResult =
        [
            Result<[Trending], DataException>.success(trendingList),
            Result<[Trending], DataException>.failure(DataException.DataNotFoundException())
        ].randomElement()!
        let cacheFailure = Result<[Trending], DataException>.failure(DataException.DataNotFoundException())
        stub(cacheDatasource){ mock in
            when(mock.get(query: any())).thenReturn(cacheFailure, expectedResult)
            when(mock.put(query: any(), data: trendingList)).thenReturn(expectedResult)
        }
        stub(mainDatasource){ mock in
            when(mock.get(query: any())).thenReturn(mainSuccessful)
        }
        
        let actualResult = repository.get(query: query, operation: Operation.cacheElseMain)
    
        verify(cacheDatasource, times(2)).get(query: query)
        verify(cacheDatasource).put(query: query, data: trendingList)
        verify(mainDatasource).get(query: query)
        expect(actualResult).to(equal(expectedResult))
    }
    
    func test_assert_data_fetched_from_cache_datasource_when_data_exists(){
        let query = GetTrendingQuery.getAllTrendginQuery
        let trendingList = randomNumberOf(){ randomTrending() }
        let expectedResult = Result<[Trending], DataException>.success(trendingList)
        stub(cacheDatasource){ mock in
            when(mock.get(query: any())).thenReturn(expectedResult)
        }
        
        let actualResult = repository.get(query: query, operation: Operation.cacheElseMain)
        
        verify(cacheDatasource).get(query: query)
        verify(cacheDatasource, times(0)).put(query: query, data: trendingList)
        verify(mainDatasource, times(0)).get(query: query)
        expect(actualResult).to(equal(expectedResult))
    }
    
    func test_assert_data_cached_when_main_sync_is_successful(){
        let query = GetTrendingQuery.getAllTrendginQuery
        let trendingList = randomNumberOf(){ randomTrending() }
        let mainSuccessful = Result<[Trending], DataException>.success(trendingList)
        let expectedResult =
        [
            Result<[Trending], DataException>.success(trendingList),
            Result<[Trending], DataException>.failure(DataException.DataNotFoundException())
        ].randomElement()!
        stub(mainDatasource){mock in
            when(mock).get(query: any()).thenReturn(mainSuccessful)
        }
        stub(cacheDatasource){mock in
            when(mock).put(query: any(), data: trendingList).thenReturn(expectedResult)
            when(mock).get(query: any()).thenReturn(expectedResult)
        }
        
        let actualResult = repository.get(query: query, operation: Operation.mainElseCache)
        
        verify(mainDatasource).get(query: query)
        verify(cacheDatasource).get(query: query)
        verify(cacheDatasource).put(query: query, data: trendingList)
        expect(actualResult).to(equal(expectedResult))
    }
    
    func test_assert_data_cached_when_main_sync_failed(){
        let query = GetTrendingQuery.getAllTrendginQuery
        let trendingList = randomNumberOf(){ randomTrending() }
        let mainFailure = Result<[Trending], DataException>.failure(DataException.DataNotFoundException())
        let expectedResult =
        [
            Result<[Trending], DataException>.success(trendingList),
            Result<[Trending], DataException>.failure(DataException.DataNotFoundException())
        ].randomElement()!
        stub(mainDatasource){mock in
            when(mock).get(query: any()).thenReturn(mainFailure)
        }
        stub(cacheDatasource){mock in
            when(mock).get(query: any()).thenReturn(expectedResult)
        }
        
        let actualResult = repository.get(query: query, operation: Operation.mainElseCache)
        
        verify(mainDatasource).get(query: query)
        verify(cacheDatasource).get(query: query)
        verify(cacheDatasource, times(0)).put(query: query, data: trendingList)
        expect(actualResult).to(equal(expectedResult))
    }
}
