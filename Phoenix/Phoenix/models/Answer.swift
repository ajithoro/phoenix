//
//  Answer.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import Foundation
import ObjectMapper

class Answer: Mappable {
    var answerId:Int?
    var questionId:Int?
    var score:Int?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        answerId <- map["answer_id"]
        questionId <- map["question_id"]
        score <- map["score"]
    }
}
