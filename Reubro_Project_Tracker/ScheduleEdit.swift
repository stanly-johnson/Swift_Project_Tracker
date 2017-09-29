//
//  ScheduleEdit.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 29/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class ScheduleEdit: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var startDatePicker: UIView!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
