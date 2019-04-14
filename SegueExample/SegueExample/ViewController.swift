//
//  ViewController.swift
//  SegueExample
//
//  Created by Zed on 4/10/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func GoToSecondButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecondSegue", sender: nil)
    }
}

