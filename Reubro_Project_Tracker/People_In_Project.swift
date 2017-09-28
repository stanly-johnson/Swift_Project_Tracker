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

    @IBOutlet weak var personPicker: UIPickerView!
    var pickerData: [String] = [String]()
    var person:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personPicker.delegate = self
        self.personPicker.dataSource = self
       pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

    
    // MARK: - Navigation
    
    @IBAction func actionCancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
