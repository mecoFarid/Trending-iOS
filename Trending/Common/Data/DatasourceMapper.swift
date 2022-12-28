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

    init(datasource: any Datasource<I, E>, outMapper: any Mapper<I, O>, inMapper: any Mapper<O, I>) {
        self.datasource = datasource
        self.outMapper = outMapper
        self.inMapper = inMapper
    }

    func get(query: Query) -> Result<O, DataException> {
        return datasource.get(query: query).map{ result in
            outMapper.map(i: result.self)
        }
    }

    func put(query: Query, data: O) -> Result<O, DataException> {
        let data = inMapper.map(i: data)
        
        return datasource.put(query: query, data: data).map({ result in
            outMapper.map(i: result.self)
        })
    }
}
