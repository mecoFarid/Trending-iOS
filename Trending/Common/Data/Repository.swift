//
//  Repository.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
protocol Repository<T, E>{
    associatedtype T
    associatedtype E: DataException
    func get(query: Query, operation: Operation) async -> Result<T, E>
}
