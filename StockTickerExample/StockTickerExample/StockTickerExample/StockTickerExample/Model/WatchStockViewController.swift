//
//  ViewController.swift
//  StockTickerExample
//
//  Created by Ashish on 2/19/19.
//  Copyright © 2019 Ashish. All rights reserved.
//

import UIKit

class WatchStockViewController: UIViewController, AddStockProtocol {
    
    
    func SendStockSymbol(symbol: String) {
        print("Symbol Sent: \(symbol)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func AddStockButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddStockSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddStockSegue" {
            
            let addStock = segue.destination as! AddStockViewController
            addStock.delegate = self
            
            
            
        }
    }
    
}

