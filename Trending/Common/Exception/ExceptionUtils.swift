//
//  ExceptionUtils.swift
//  Trending
//
//  Created by Farid Mammadov on 27.12.22.
//

import Foundation

func safeOrFail<T>(_ block: () throws -> T) -> T{
    do{
        return try block()
    }catch{
        fatalError("Failed with \(error)")
    }
}
