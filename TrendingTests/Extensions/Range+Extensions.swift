//
//  Range+Extensions.swift
//  TrendingTests
//
//  Created by Farid Mammadov on 20.12.22.
//

import Foundation

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
