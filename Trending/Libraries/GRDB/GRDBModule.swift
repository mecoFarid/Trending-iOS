//
//  GRDBModule.swift
//  Trending
//
//  Created by Farid Mammadov on 11.01.23.
//

import Foundation
import GRDB

class GRDBModule: DatabaseComponent {
    
    private lazy var dbWriter: DatabaseWriter = {
        let dbWriter = try! safeOrFail{
            let url = try FileManager.default
                .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("trending.sqlite")
            
            return try DatabaseQueue(path: url.path)
        }.get()
        
        generateTables(dbWriter)
        return dbWriter
    }()
    
    func getDatabase() -> DatabaseWriter {
        return dbWriter
    }
    
    private func generateTables(_ dbWriter: DatabaseWriter){
        TableGenerator.generatetables(dbWriter)
    }
}
