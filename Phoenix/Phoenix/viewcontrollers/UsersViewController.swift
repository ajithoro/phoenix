//
//  UsersViewController.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import UIKit

class UsersViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Users"
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
            print(response)
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
