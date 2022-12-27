//
//  Query+Extensions.swift
//  TrendingTests
//
//  Created by Farid Mammadov on 20.12.22.
//

import Foundation
import Cuckoo
@testable import Trending

extension GetTrendingQuery: Matchable{
    
    public typealias MatchedType = Query
    
    public var matcher: Cuckoo.ParameterMatcher<MatchedType> {
        return Cuckoo.ParameterMatcher<MatchedType>{ other in
            let query = other as? GetTrendingQuery
            return self == query
        }
    }
}
