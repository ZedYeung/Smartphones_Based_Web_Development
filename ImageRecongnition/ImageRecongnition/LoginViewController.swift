//
//  LoginViewController.swift
//  ImageRecongnition
//
//  Created by Zed on 4/24/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class LoginViewController: UIViewController, SignupProtocol, ForgotPasswordProtocol {
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) {
            error in
            if error == nil {
                self.lblStatus.isHidden = false
                self.lblStatus.text = "Reset email already sent"
            } else {
                self.lblStatus.isHidden = false
                self.lblStatus.text = error?.localizedDescription
            }
        }
    }
    
    func signup(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            user, error in
            if error == nil {
                self.lblStatus.isHidden = false
                self.lblStatus.text = "Sign Up success"
            } else {
                self.lblStatus.isHidden = false
                self.lblStatus.text = error?.localizedDescription
            }
        }
    }
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblStatus.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = KeychainService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    func AddKeyChainAfterLogin(uid: String){
        let keyChain = KeychainService().keyChain
        keyChain.set(uid, forKey: "uid")
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
                strongSelf.AddKeyChainAfterLogin(uid: user!.user.uid)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignupSegue" {
            let signupViewController = segue.destination as! SignupViewController
            signupViewController.delegate = self
        } else if segue.identifier == "ForgotPasswordSegue" {
            let forgotPasswordViewController = segue.destination as! ForgotPasswordViewController
            forgotPasswordViewController.delegate = self
            
        }
    }
}

