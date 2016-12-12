//
//  Question.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import Foundation
import ObjectMapper

class Question: Mappable {
    var questionId:Int?
    var score:Int?
    var title:String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        questionId <- map["question_id"]
        score <- map["score"]
        title <- map["title"]
    }
}
