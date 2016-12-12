//
//  AnswersViewController.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnswersViewController: BaseViewController {
    
    var user: User = User()

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
                    /*
                    let questionId = json["items"][0]["question_id"]
                    self.getQuestion(questionId: questionId.rawString()!)
                    */
                case .failure(let error):
                    self.showAlertMessage(title: "Error", message: "Something went wrong. Try again.")
                }
            })
        } else {
            self.showAlertMessage(title: "Error", message: "User id not available. Try other user.")
        }
       
    }
    
    func getQuestion(questionId:String) {
        self.showActivityIndicator()
        NetworkManager.sharedInstance.getQuestion(questionId: questionId, completionHandler: {(response) in
            self.hideActivityIndicator()
            print("question: \(response)")
        })
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
