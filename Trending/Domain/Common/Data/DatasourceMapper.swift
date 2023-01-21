//
//  DatasourceMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
class DatasourceMapper<I, O>: Datasource {
    private let datasource: any Datasource<I, DataException>
    private let outMapper: any Mapper<I, O>
    private let inMapper: any Mapper<O, I>

    init(_ datasource: any Datasource<I, E>, outMapper: any Mapper<I, O>, inMapper: any Mapper<O, I>) {
        self.datasource = datasource
        self.outMapper = outMapper
        self.inMapper = inMapper
    }

    func get(query: Query) async -> Result<O, DataException> {
        return await datasource.get(query: query).map{ result in
            outMapper.map(result)
        }
    }

    func put(query: Query, data: O) async -> Result<O, DataException> {
        let data = inMapper.map(data)
        
        return await datasource.put(query: query, data: data).map({ result in
            outMapper.map(result)
        })
    }
}
