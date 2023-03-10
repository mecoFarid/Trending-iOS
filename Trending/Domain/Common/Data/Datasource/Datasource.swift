//
//  Datasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

protocol Datasource<T, E>{
    associatedtype T
    associatedtype E: DataException
    func get(query: Query) async -> Result<T, E>
    func put(query: Query, data: T) async -> Result<T, E>
}
