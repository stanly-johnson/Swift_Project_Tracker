//
//  Add_New_Project.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import os.log

class Add_New_Project: UIViewController, UITextFieldDelegate {
    
   
    @IBOutlet weak var saveButton: UIBarButtonItem!   
    @IBOutlet weak var nameOfProject: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameOfProject.delegate = self
        updateSaveButtonState()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = String(nameOfProject.text!)
        if let destinationViewController = segue.destination as? ProjectScreenTableViewController{
            
            destinationViewController.nameProject = name!
        }
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = nameOfProject.text
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameOfProject.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    

    @IBAction func actionCancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
