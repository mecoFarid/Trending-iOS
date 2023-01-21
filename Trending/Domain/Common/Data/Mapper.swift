//
//  Mapper.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation
protocol Mapper<I, O>{
    associatedtype I
    associatedtype O
    
    func map(_ i: I) -> O
}

class VoidMapper<I, O> : Mapper {
    func map(_ i: I) -> O {
        RuntimeException.notImplemented()
    }
}

class ListMapper<I, O>: Mapper {
    
    let mapper: any Mapper<I, O>
    
    init(_ mapper: any Mapper<I, O>) {
        self.mapper = mapper
    }
    
    func map(_ i: [I]) -> [O] {
        return i.map{ input in
            mapper.map(input)
        }
    }
}
