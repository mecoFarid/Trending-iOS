//
//  BaseRouter.swift
//  Trending
//
//  Created by Farid Mammadov on 30.12.22.
//

import Foundation
import Alamofire

struct BaseRouter: URLRequestConvertible{
    private let baseUrl: URL = URL(string: "https://api.github.com")!
    
    private let method: HTTPMethod
    private let requestOptions: RequestOptions
    
    fileprivate init(_ method: HTTPMethod, requestOptions: RequestOptions) {
        self.method = method
        self.requestOptions = requestOptions
    }
    
    static func GET(requestOptions: RequestOptions) -> BaseRouter {
        return BaseRouter(.get, requestOptions: requestOptions)
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(requestOptions.path)
        let request = try! URLRequest(url: url, method: method)
        return try! requestOptions.encoder.encode(requestOptions.parameters, into: request)
    }
}

typealias Parameters = [String: String]

struct RequestOptions{
    
    let path: String
    let parameters: Parameters?
    let encoder: ParameterEncoder
    
    init(
        path: String,
        parameters: Parameters? = nil,
        encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default
    ) {
        self.path = path
        self.parameters = parameters
        self.encoder = encoder
    }
}
