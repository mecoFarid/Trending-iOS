//
//  NetworkDatasource.swift
//  Trending
//
//  Created by Farid Mammadov on 07.02.23.
//

import Foundation
import Alamofire

class NetworkDatasource<T, E: DataException>: Datasource{
    
    private let service: any NetworkService<T>
    private let exceptionMapper: any Mapper<NetworkException, E>
    
    init(service: any NetworkService<T>, exceptionMapper: any Mapper<NetworkException, E>) {
        self.service = service
        self.exceptionMapper = exceptionMapper
    }
    
    func put(query: Query, data: T) async -> Result<T, E> {
        return await executeRequest({ try await service.put(query: query, data: data) })
    }
    
    func get(query: Query) async -> Result<T, E> {
        return await executeRequest({ try await service.get(query: query) })
    }
    
    private func executeRequest(_ closure:() async throws -> T) async -> Result<T, E>{
        return await Result(catchingSpecific: closure)
    }
}
