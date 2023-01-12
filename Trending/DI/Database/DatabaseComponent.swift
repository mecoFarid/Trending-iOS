//
//  DatabaseComponent.swift
//  Trending
//
//  Created by Farid Mammadov on 11.01.23.
//

import Foundation
import GRDB

protocol DatabaseComponent{
    func getDatabase() -> DatabaseWriter
}
