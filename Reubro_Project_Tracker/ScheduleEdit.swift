//
//  ScheduleEdit.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 29/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class ScheduleEdit: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    let max_hours = 500
    var selectedProject = String()
    var selectedHours = String()
    var startDate = String()
    var endDate = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hourPicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    //MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return max_hours
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(row + 1)"
    }
        
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       selectedHours = String(pickerView.selectedRow(inComponent: 0) + 1)
    }
    
    // MARK: - Actions
    
    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func startDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        startDate = dateFormatter.string(from: startDatePicker.date)
        print ("Start Date set to \(startDate)")
    }
    
    
    @IBAction func endDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        endDate = dateFormatter.string(from: endDatePicker.date)
        print ("End Date set to \(endDate)")
    }
    
    @IBAction func actionSaveButton(_ sender: Any) {
        
        if let presenter = presentingViewController as? Add_New_Project {
            presenter.start_date = startDate
            presenter.end_date = endDate
            presenter.hours_project = selectedHours
        }
        dismiss(animated: true, completion: nil)
        
    }

}
