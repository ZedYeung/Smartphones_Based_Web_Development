//
//  ForgotPasswordViewController.swift
//  InstaHappy
//
//  Created by Zed on 4/18/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var delegate: ForgotPasswordProtocol?
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblStatus.isHidden = true
    }

    @IBAction func resetPasswordPressed(_ sender: Any) {
        let email = txtEmail.text!
        
        if email.isEmail == false{
            lblStatus.isHidden = false
            lblStatus.text = "Enter a valid e mail"
            return
        }
        
        delegate?.resetPassword(email: email)
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
