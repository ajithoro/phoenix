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
    @IBOutlet weak var tableViewAnswers: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Questions Asked"
        self.automaticallyAdjustsScrollViewInsets = false
        // TableView
        self.tableViewAnswers.delegate = self
        self.tableViewAnswers.dataSource = self
        // get answers for a user
        self.getAnswers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // get answers for a user
    func getAnswers() {
        if let userId = self.user.userId {
            self.showActivityIndicator()
            NetworkManager.sharedInstance.getAnswers(userId: String(userId), completionHandler: {(response) in
                self.hideActivityIndicator()
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
                        self.showAlertMessage(title: "", message: "No answers found. Try other user.")
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
    
    // get questions for a user
    func getQuestions() {
        // adding all questions network calls to dispatch group
        let questionsGroup = DispatchGroup.init()
        
        for answer in self.answers {
            if let questionId = answer.questionId {
                questionsGroup.enter()
                self.showActivityIndicator()
                NetworkManager.sharedInstance.getQuestion(questionId: String(questionId), completionHandler: {(response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let questionJson = json["items"]
                        if let jsonString = questionJson.rawString() {
                            if let questionArray = Mapper<Question>().mapArray(JSONString: jsonString) {
                                self.questions.append(contentsOf: questionArray)
                                self.tableViewAnswers.reloadData()
                            }
                        }
                        
                    case .failure(let error):
                        print("error: \(error.localizedDescription)")
                    }
                    
                    questionsGroup.leave()
                })
            }
        }
        
        questionsGroup.notify(queue: DispatchQueue.main, execute: {
            self.hideActivityIndicator()
            if self.questions.isEmpty {
                self.showAlertMessage(title: "", message: "No question found. Try other user.")
            }
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

extension AnswersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellAnswer, for: indexPath)
        cell.textLabel?.text = self.questions[indexPath.row].title ?? ""
        return cell
    }

}

extension AnswersViewController: UITableViewDelegate {
    
}
