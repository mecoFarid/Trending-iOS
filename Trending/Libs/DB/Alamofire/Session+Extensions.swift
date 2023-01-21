//
//  Session+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 30.12.22.
//

import Foundation
import Alamofire

extension Session{
    func executeRequest<T: Decodable>(_ dataRequest: URLRequestConvertible) async -> Result<T, DataException>{
        let result = await request(dataRequest).validate().serializingDecodable(T.self).result
        
        switch(result){
            
        case .success(let data): return Result.success(data)
        case .failure(_): return Result.failure(DataException.DataNotFoundException())
        }
    }
}
