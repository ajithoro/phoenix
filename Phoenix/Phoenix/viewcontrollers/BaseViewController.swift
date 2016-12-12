//
//  BaseViewController.swift
//  Phoenix
//
//  Created by Unholy Saint on 12/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicatorView.center = self.view.center
        self.activityIndicatorView.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicatorView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator() {
        self.activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicatorView.stopAnimating()
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
