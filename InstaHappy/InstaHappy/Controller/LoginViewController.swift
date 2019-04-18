//
//  ViewController.swift
//  InstaHappy
//
//  Created by Zed on 4/15/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblStatus.isHidden = true
    }


    @IBAction func LoginPressed(_ sender: Any) {
    }
    
    
    @IBAction func ForgotPasswordPressed(_ sender: Any) {
    }
    
    
    @IBAction func SignupPressed(_ sender: Any) {
    }
}

