//
//  DatasourceMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
class DatasourceMapper<I, O, D: Datasource, E: DataException>: Datasource where D.T == I, D.E == E {
    
    private let datasource: D
    private let outMapper: any Mapper<I, O>
    private let inMapper: any Mapper<O, I>

    init(_ datasource: D, outMapper: any Mapper<I, O>, inMapper: any Mapper<O, I>) {
        self.datasource = datasource
        self.outMapper = outMapper
        self.inMapper = inMapper
    }

    func get(query: Query) async -> Result<O, E> {
        return await datasource.get(query: query).map{ result in
            outMapper.map(result)
        }
    }

    func put(query: Query, data: O) async -> Result<O, E> {
        let data = inMapper.map(data)
        
        return await datasource.put(query: query, data: data).map({ result in
            outMapper.map(result)
        })
    }
}
