//
//  ViewController.swift
//  Phoenix
//
//  Created by Nitin Kumar on 08/12/16.
//  Copyright © 2016 Ajit Horo. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getUsersButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: kSegueUsers, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == kSegueUsers) {
            
        }
    }

}

