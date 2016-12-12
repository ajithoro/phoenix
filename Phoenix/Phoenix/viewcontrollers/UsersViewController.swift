//
//  UsersViewController.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class UsersViewController: BaseViewController {
    
    var users:[User] = [User]()
    @IBOutlet weak var tableViewUsers: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Users"
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableViewUsers.separatorStyle = .singleLine
        self.tableViewUsers.delegate = self
        self.tableViewUsers.dataSource = self
        self.getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUsers() {
        self.showActivityIndicator()
        NetworkManager.sharedInstance.getUsers { (response) in
            self.hideActivityIndicator()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let usersJson = json["items"]
                if let jsonString = usersJson.rawString() {
                    if let userArray = Mapper<User>().mapArray(JSONString: jsonString) {
                        self.users = userArray
                        self.tableViewUsers.reloadData()
                    }
                }
                
                if self.users.isEmpty {
                    self.showAlertMessage(title: "", message: "No user found. Try again.")
                }
                
            case .failure(let error):
                print("err: \(error.localizedDescription)")
                self.showAlertMessage(title: "Error", message: "Something went wrong. Try again.")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellUser, for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].displayName
        return cell
    }
    
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
