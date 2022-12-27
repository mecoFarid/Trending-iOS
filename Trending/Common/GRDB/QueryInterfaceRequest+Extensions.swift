//
//  FetchableRecord+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 27.12.22.
//

import Foundation
import GRDB

extension QueryInterfaceRequest{
    public func fetchAllOrFail<RowDecoder: FetchableRecord>(_ db: Database) -> [RowDecoder] {
        safeOrFail { try RowDecoder.fetchAll(db, self) }
    }
}
