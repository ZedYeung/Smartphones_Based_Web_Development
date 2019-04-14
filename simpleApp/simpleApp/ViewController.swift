//
//  ViewController.swift
//  simpleApp
//
//  Created by Zed on 4/14/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func changeBackgroudRed(_ sender: UIButton) {
        view.backgroundColor = .red
    }
    
    @IBAction func changeBackgroundGreen(_ sender: UIButton) {
        view.backgroundColor = .green
    }
}

