//
//  ChangeCityViewController.swift
//  SeattleWeatherApp
//
//  Created by Ashish on 2/13/19.
//  Copyright © 2019 Ashish. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController {

    var delegate: ChangeCityProtocol?
    
    @IBOutlet weak var txtFieldCity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func BackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ChangeCityButtonPressed(_ sender: UIButton) {
        let cityName = txtFieldCity.text!
        delegate?.ChangeCityFunction(cityName: cityName)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
