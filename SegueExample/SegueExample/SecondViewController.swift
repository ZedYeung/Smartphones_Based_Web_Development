//
//  SecondViewController.swift
//  SegueExample
//
//  Created by Zed on 4/10/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func GoToFirstPageSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFirstSegue", sender: nil)
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
