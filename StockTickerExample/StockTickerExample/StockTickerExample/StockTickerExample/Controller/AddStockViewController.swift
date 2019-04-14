//
//  AddStockViewController.swift
//  StockTickerExample
//
//  Created by Ashish on 2/19/19.
//  Copyright © 2019 Ashish. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

let apikey = "FRFE7TLX1BL2CH0H"
let API_URL = "https://www.alphavantage.co/query"

class AddStockViewController: UIViewController {

    var delegate: AddStockProtocol?
    
    @IBOutlet weak var txtStockSymbol: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddStockButtonpressed(_ sender: UIButton) {
        
        if let symbol = txtStockSymbol.text {
            
            let params: [String: String] = ["function":"GLOBAL_QUOTE",
                                            "symbol": symbol,
                                            "apikey": "FRFE7TLX1BL2CH0H"]
            GetStockValues(params: params)
            
            //delegate?.SendStockSymbol(symbol: "TSLA")
           // self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func GetStockValues(params: [String:String]){
        
        SVProgressHUD.show()
        Alamofire.request(API_URL, method: .get, parameters: params).responseJSON{
            response in
            
            if response.result.isSuccess {
                SVProgressHUD.dismiss()
                let stockJSON: JSON = JSON(response.result.value!)
                
                if stockJSON["Global Quote"].count == 0{
                    self.lblStatus.text = "Wrong Stock Symbol"
                    return
                }
                let stockValue = stockJSON["Global Quote"]["05. price"].doubleValue
                
                self.lblStatus.text = "Stock price = \(stockValue)"
            }else{
                SVProgressHUD.dismiss()
                print("Unsuccessful")
            }
        }
        
    }
    

}
