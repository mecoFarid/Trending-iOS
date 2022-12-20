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
