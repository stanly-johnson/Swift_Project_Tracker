//
//  People_In_Project.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 22/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData
import os.log

class People_In_Project: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
   
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var personPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var person:[NSManagedObject] = []
    var fetch_count = 0
    
    let max_hours = 30 //change this value to change the max hours shown with picker view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFromDB()
        //personPicker.selectRow(3, inComponent: 0, animated: true)
        
    }

    
    override func viewDidLayoutSubviews()
    {
        let scrollViewBounds = scrollView.bounds
        let containerViewBounds = contentView.bounds
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height/2.0;
        scrollViewInsets.top -= contentView.bounds.size.height/2.0;
        scrollViewInsets.bottom = scrollViewBounds.size.height/2.0
        scrollViewInsets.bottom -= contentView.bounds.size.height/2.0;
        scrollViewInsets.bottom += 1
        scrollView.contentInset = scrollViewInsets
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == personPicker
        {
            if(fetch_count == 0)
            {
                actionPersonEmptyAlert()
            }
        
            return fetch_count;
        }
        
        else if pickerView == hourPicker
        {
            return 10
        }
        
        return 0 //ideally this value is never returned
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == personPicker
        {
            return pickerData[row]
        }
        
        else if pickerView == hourPicker
        {
            
            return "\(row + 1)"
        }
        
        return "" //ideally this value is never returned
    }
    
    // MARK: - Alert
    
    func actionPersonEmptyAlert()
    {
        let alert = UIAlertController(title: "Warning", message: "There are no people to assign projects. Add people from the people tab to continue.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .destructive){ (action:UIAlertAction!) in
         self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Database
    
    func fetchFromDB()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest <NSFetchRequestResult>(entityName : "Person")
        request.returnsObjectsAsFaults = false
        
        do
        {
            person = try context.fetch(request) as! [NSManagedObject]
            if person.count > 0
            {
                for row in 0...person.count-1
                {
                let displayName = person[row]
                let fetch_name = displayName.value(forKeyPath: "name") as? String
                pickerData.append(fetch_name!)
                }
            }
            
        }
        catch
        {
            print("Fetch operation failed")
        }
        
        fetch_count = person.count
        
    }
    
    // MARK: - Navigation
    
    @IBAction func actionCancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
