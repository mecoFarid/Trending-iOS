//
//  TestUtils.swift
//  TrendingTests
//
//  Created by Farid Mammadov on 19.12.22.
//

import Foundation
import Cuckoo
@testable import Trending

internal func randomInt(min: Int = Int.min, max: Int = Int.max) -> Int {
    return Int.random(in: min...max)
}

internal func randomString(
    length: Int = 10,
    source: [Character] = ("a"..."z").toArray() + ("A"..."Z").toArray()
) -> String{
    return String((0..<length).map{ _ in source.randomElement()! })
}

internal func randomNullable<T>(block:() -> T) -> T? {
    if Bool.random() {
        return block()
    }else{
        return nil
    }
}

internal func randomNumberOf<T>(length: Int = 10, block: () -> T) -> [T]{
    return (0..<length).map{ _ in block() }
}

internal extension ClosedRange where Bound == UnicodeScalar {
    func toArray() -> [Character] {
        (lowerBound.value...upperBound.value).compactMap {
            guard let unicodeScalar = UnicodeScalar($0) else{
                fatalError("\($0) Could not be converted to UnicodeScalar")
            }
            return Character(unicodeScalar)
        }
    }
}


extension Result: Matchable where Success: Equatable, Failure: Equatable{
    
    public typealias MatchedType = Success
    
    public var matcher: Cuckoo.ParameterMatcher<Success> {
        return ParameterMatcher<Success> { other in
            var matched = false
            onSuccess{ success in
                matched = success == other
            }
            return matched
        }
    }
}
