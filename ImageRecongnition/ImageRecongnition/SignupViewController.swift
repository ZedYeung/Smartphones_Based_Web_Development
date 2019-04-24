//
//  SignupViewController.swift
//  InstaHappy
//
//  Created by Zed on 4/24/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    var delegate: SignupProtocol?
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtSecondPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblStatus.isHidden = true
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        let secondPassword = txtSecondPassword.text!
        
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
        if password != secondPassword {
            lblStatus.isHidden = false
            lblStatus.text = "Password mismatch"
            return
        }
        
        delegate?.signup(email: email, password: password)

        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
