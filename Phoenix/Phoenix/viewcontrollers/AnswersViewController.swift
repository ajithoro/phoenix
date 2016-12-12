//
//  AnswersViewController.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class AnswersViewController: BaseViewController {
    
    var user: User = User()
    var answers:[Answer] = [Answer]()
    var questions:[Question] = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getAnswers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAnswers() {
        if let userId = self.user.userId {
            self.showActivityIndicator()
            NetworkManager.sharedInstance.getAnswers(userId: String(userId), completionHandler: {(response) in
                self.hideActivityIndicator()
                print("resp: \(response)")
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let answersJson = json["items"]
                    if let jsonString = answersJson.rawString() {
                        if let answersArray = Mapper<Answer>().mapArray(JSONString: jsonString) {
                            self.answers = answersArray
                        }
                    }
                    
                    if self.answers.isEmpty {
                        self.showAlertMessage(title: "", message: "No answers found. Try again.")
                    } else {
                        self.getQuestions()
                    }
                    
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    self.showAlertMessage(title: "Error", message: "Something went wrong. Try again.")
                }
            })
        } else {
            self.showAlertMessage(title: "Error", message: "User id not available. Try other user.")
        }
       
    }
    
    func getQuestions() {
        
        for answer in self.answers {
            self.showActivityIndicator()
            if let questionId = answer.questionId {
                NetworkManager.sharedInstance.getQuestion(questionId: String(questionId), completionHandler: {(response) in
                    self.hideActivityIndicator()
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let questionJson = json["items"]
                        if let questionArray = Mapper<Question>().mapArray(JSONString: questionJson.rawString()!) {
                            self.questions.append(contentsOf: questionArray)
                            for question in self.questions {
                                print("q: \(question.title ?? "")")
                            }
                        }
                    case .failure(let error):
                        print("error: \(error.localizedDescription)")
                    }
                })
            }
        }
    }
    
    /*
    func getAnswer(answerId:String) {
        self.showActivityIndicator()
        NetworkManager.sharedInstance.getAnswer(answerId: answerId, completionHandler: {(response) in
            self.hideActivityIndicator()
            print("ans: \(response)")
        })
    }
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
