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
    
    // Singleton Class
    static let sharedInstance = NetworkManager()
    typealias CompletionClosure = ((DataResponse<Any>) -> Void)?
    
    private init() {
        
    }
    
    // get stack overflow users
    func getUsers(completionHandler: CompletionClosure) {
        let usersUrl:String = kBaseUrl + "users?key=\(kAPIKey)&order=desc&sort=reputation&site=stackoverflow"
        Alamofire.request(usersUrl).responseJSON { (response) in
            completionHandler!(response)
        }
    }
    
    // get answers answered by a user
    func getAnswers(userId:String, completionHandler:CompletionClosure) {
        let answersUrl:String = kBaseUrl + "users/\(userId)/answers?key=\(kAPIKey)&order=desc&sort=activity&site=stackoverflow"
        Alamofire.request(answersUrl).responseJSON { (response) in
            completionHandler!(response)
        }
    }
    
    // get question from question id
    func getQuestion(questionId:String, completionHandler:CompletionClosure) {
        let questionUrl:String = kBaseUrl + "questions/\(questionId)?key=\(kAPIKey)&order=desc&sort=activity&site=stackoverflow"
        Alamofire.request(questionUrl).responseJSON { (response) in
            completionHandler!(response)
        }
    }
    
    /*
    func getAnswer(answerId:String, completionHandler:CompletionClosure) {
        let answerUrl:String = kBaseUrl + "answers/\(answerId)?order=desc&sort=activity&site=stackoverflow"
        Alamofire.request(answerUrl).responseJSON { (response) in
            completionHandler!(response)
        }
    }
    */
    
}
