//
//  Add_New_User.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class Add_New_User: UIViewController {

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!   
    @IBOutlet weak var desg: UITextField!
    @IBOutlet weak var rate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func actionSaveButtonPressed(_ sender: Any) {
        
        let saveConfirmAlert = UIAlertController(title: "New Person Added", message: "A new person has been added", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"OK", style:.default) { (action:UIAlertAction!) in
            
         self.dismiss(animated: true, completion: nil)
            
        }
        saveConfirmAlert.addAction(okAction)
        present(saveConfirmAlert, animated: true, completion: nil)
        
    }
    

    @IBAction func actionCancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  
}
