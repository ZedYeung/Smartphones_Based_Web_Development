//
//  ViewController.swift
//  StoreData
//
//  Created by Ashish on 2/19/19.
//  Copyright © 2019 Ashish. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list:[AnyObject] = [AnyObject]()

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        table.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func RefreshData(){
        list = ReadData(entity: "Stock")
        table.reloadData()
    }
    
    @IBAction func AddButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Store new element", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Stock Symbol"
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            if let s = textField?.text
            {
                self.WriteData("Stock", ["symbol":s , "price": 23.45])
                self.RefreshData()
               
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let title = list[indexPath.row].value(forKey: "symbol") as? String
        {
            if let price = list[indexPath.row].value(forKey: "price") as? Double{
                cell.textLabel?.text = title + ": " + String(price)
            }
            
        }
        return cell
    }
    
    func ReadData(entity:String) ->[AnyObject]{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        do{
            let fetchResults = try context.fetch(fetchRequest)
            if let results = fetchResults as? [NSManagedObject]{
                return results
            }
            
        }catch{
            
            
        }
        return [AnyObject]()
 
    }
    
    func WriteData(_ entity: String, _ listKVPairs: [String: Any ]){
        // Get app delegate and the view context of the Core Data ( persistentContainer)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Get Our Entity and the Object which will insert value in the entity
        let entity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)
        let obj = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // For every key Value add data
        for (key,value) in listKVPairs
        {
            obj.setValue(value, forKey: key)
        }
        
        // Save Data in the Core Data container.
        do
        {
            try managedContext.save()
        }
        catch
        {
            print("Error: \(error)")
        }
        
    }
    


}

