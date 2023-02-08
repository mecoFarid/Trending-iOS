//
//  NetworkService.swift
//  Trending
//
//  Created by Farid Mammadov on 07.02.23.
//

import Foundation

protocol NetworkService<T> {
    associatedtype T
    func get(query: Query) async throws -> T
    func put(query: Query, data: T) async throws -> T
}
