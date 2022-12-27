//
//  Trending+Extensions.swift
//  TrendingTests
//
//  Created by Farid Mammadov on 20.12.22.
//

import Foundation
import Cuckoo
@testable import Trending

extension Trending: Matchable{
    
    public typealias MatchedType = Trending
    
    public var matcher: Cuckoo.ParameterMatcher<Trending> {
        return ParameterMatcher<Trending> { other in
            return self == other
        }
    }
}
