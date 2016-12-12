//
//  File.swift
//  Phoenix
//
//  Created by Nitin Kumar on 08/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    typealias CompletionClosure = ((DataResponse<Any>) -> Void)?
    
    private init() {
        
    }
    
    func getUsers(completionHandler: CompletionClosure) {
        let usersUrl:String = kBaseUrl + "users?order=desc&sort=reputation&site=stackoverflow"
        Alamofire.request(usersUrl).responseJSON { (response) in
            completionHandler!(response)
        }
    }
    
}
