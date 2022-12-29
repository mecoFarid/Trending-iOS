//
//  ExceptionUtils.swift
//  Trending
//
//  Created by Farid Mammadov on 27.12.22.
//

import Foundation

@discardableResult
func safeOrFail<T, E: DataException>(_ block: () throws -> T) -> Result<T, E>{
    do{
        return try Result.success(block())
    }catch{
        fatalError("Failed with \(error)")
    }
}
