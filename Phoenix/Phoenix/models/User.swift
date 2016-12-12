//
//  User.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var accountId:Int?
    var userId:Int?
    var link:String?
    var profileImage:String?
    var displayName:String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        accountId <- map["account_id"]
        userId <- map["user_id"]
        link <- map["link"]
        profileImage <- map["profile_image"]
        displayName <- map["display_name"]
    }
    
}
