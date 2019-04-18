//
//  ViewController.swift
//  InstaHappy
//
//  Created by Zed on 4/15/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

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
        let email = txtEmail.text!
        let password = txtPassword.text!

        if email.isEmail == false{
            lblStatus.isHidden = false
            lblStatus.text = "Enter a valid e mail"
            return
        }
        if password.count < 6 {
            lblStatus.isHidden = false
            lblStatus.text = "Enter correct password"
            return
        }

        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }

            SVProgressHUD.dismiss()
            if error == nil{
               // perform segue
                strongSelf.lblStatus.isHidden = false
                strongSelf.performSegue(withIdentifier: "LoginSegue", sender: strongSelf)
            }
            else{
                strongSelf.lblStatus.text = error?.localizedDescription
                return
            }
        }
    }


    @IBAction func ForgotPasswordPressed(_ sender: Any) {
        performSegue(withIdentifier: "ForgotPasswordSegue", sender: self)
    }


    @IBAction func SignupPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignupSegue", sender: self)
    }
}

