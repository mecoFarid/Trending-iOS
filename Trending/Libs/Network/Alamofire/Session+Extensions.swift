//
//  Session+Extensions.swift
//  Trending
//
//  Created by Farid Mammadov on 30.12.22.
//

import Foundation
import Alamofire

extension Session{
    func executeRequest<T: Decodable>(_ dataRequest: URLRequestConvertible) async throws -> T{
        do{
            return try await request(dataRequest).validate().serializingDecodable(T.self).value
        }catch let error as AFError {
            if let code = error.responseCode{
                throw NetworkException.HttpException(code)
            }
            throw NetworkException.ConnectionException()
        }
    }
}
