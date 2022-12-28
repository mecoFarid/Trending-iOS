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
    
    func map(i: I) -> O
}
