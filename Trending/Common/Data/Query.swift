//
//  Query.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Foundation

protocol Query{}

extension Query{
    func asSpecificQuery<Q: Query>() -> Q{
        if self is Q  {
            return self as! Q
        }else {
            fatalError("Query not supported\(self)")
        }
    }
}
