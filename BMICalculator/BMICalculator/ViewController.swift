//
//  ViewController.swift
//  BMICalculator
//
//  Created by Zed on 4/14/19.
//  Copyright © 2019 Zed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isImperial: Bool = true
    
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var weightUnit: UILabel!
   
    @IBOutlet weak var heightFtText: UITextField!
    @IBOutlet weak var heightInchText: UITextField!
    
    @IBOutlet weak var bmiValue: UILabel!
    
    @IBOutlet weak var bmiResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func imperialswitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            weightUnit.text = "Lbs"
            isImperial = true
        } else {
            weightUnit.text = "Kg"
            isImperial = false
        }
    }
    
    @IBAction func bmiCalculateButton(_ sender: UIButton) {
        let weight: Int? = Int(weightText.text!)
        let heightFt: Int? = Int(heightFtText.text!)
        let heightInch: Int? = Int(heightInchText.text!)
        
        if (weight == nil || heightFt == nil || heightInch == nil || (heightFt == 0 && heightInch == 0)) {
            bmiValue.text = "Invalid"
            bmiResult.text = "No result for invalid BMI value"
        }
        
        let bmi = getBMIValue(weight: weight!, heightFt: heightFt!, heightInch: heightInch!, isImperial: isImperial)
        let res = getBMIResult(bmi: bmi)
        
        bmiValue.text = "\(bmi)"
        bmiResult.text = "\(res)"
    }
    
    func getBMIValue(weight: Int, heightFt:Int, heightInch: Int, isImperial: Bool) -> Double {
        var w: Double = Double(weight)
        
        w = isImperial ? w * 0.453592 : w
        let h = Double(heightFt) * 0.3048 + Double(heightInch) * 0.0254
        
        return w / (h * h)
    }
    
    func getBMIResult(bmi: Double) -> String {
        if (bmi >= 30) {
            return "Obese"
        } else if (bmi < 30 && bmi >= 25) {
        return "Overweight"
        } else if (bmi < 25 && bmi >= 18.5) {
            return "Normal"
        } else {
            return "Underweight"
        }
    }
}

