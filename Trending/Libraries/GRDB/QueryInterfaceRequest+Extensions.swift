//
//  FetchableRecord+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 27.12.22.
//

import Foundation
import GRDB

extension QueryInterfaceRequest{
    func fetchAllOrFail<RowDecoder: FetchableRecord>(_ dbWriter: DatabaseReader) async -> Result<[RowDecoder], DataException> {
        return await safeOrFail {
            try await dbWriter.read{ db in
                try RowDecoder.fetchAll(db, self)
            }
        }
    }
}
