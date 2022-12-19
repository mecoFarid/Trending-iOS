//
//  DatasourceMapper.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
class DatasourceMapper<D: Datasource, OM: Mapper, IM: Mapper, I, O, E: DataException>: Datasource
where D.T == I, D.E == E, OM.I == I, OM.O == O, IM.I == O, IM.O == I {
    
    private let dataSource: D
    private let outMapper: OM
    private let inMapper: IM
    
    init(dataSource: D, outMapper: OM, inMapper: IM) {
        self.dataSource = dataSource
        self.outMapper = outMapper
        self.inMapper = inMapper
    }
    
    func get(query: Query) -> Result<O, E> {
        return dataSource.get(query: query).map({ result in
            outMapper.map(i: result.self)
        })
    }
    
    func put(query: Query, data: O) -> Result<O, E> {
        let data = inMapper.map(i: data)
        return dataSource.put(query: query, data: data).map({ result in
            outMapper.map(i: result.self)
        })
    }
}
