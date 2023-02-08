//
//  NetworkException.swift
//  Trending
//
//  Created by Farid Mammadov on 07.02.23.
//

import Foundation

class NetworkException: DataException {
    class HttpException: NetworkException{
        let code: Int
        init(_ code: Int) {
            self.code = code
        }
    }
    class ConnectionException: NetworkException{}
}
