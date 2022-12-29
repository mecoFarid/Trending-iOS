//
//  FetchableRecord+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 27.12.22.
//

import Foundation
import GRDB

extension QueryInterfaceRequest{
    func fetchAllOrFail<RowDecoder: FetchableRecord>(_ db: Database) -> Result<[RowDecoder], DataException> {
        return safeOrFail {
            try RowDecoder.fetchAll(db, self)
        }
    }
}
