//
//  AlamofireModule.swift
//  Trending
//
//  Created by Farid Mammadov on 11.01.23.
//

import Foundation
import Alamofire

class AlamofireModule: NetworkComponent{
    private lazy var session: Session = { Session.default }()
    
    func getSesssion() -> Session {
        return session
    }
}
