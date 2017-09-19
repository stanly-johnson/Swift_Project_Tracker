//
//  Add_New_Project.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class Add_New_Project: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func actionAddNewProject(_ sender: Any) {
        
        let saveConfirmAlert2 = UIAlertController(title: "New Project Added", message: "A new project has been added", preferredStyle: UIAlertControllerStyle.alert)
        let okAction2 = UIAlertAction(title:"OK", style:.default) { (action:UIAlertAction!) in
            
            self.dismiss(animated: true, completion: nil)
            
        }
        saveConfirmAlert2.addAction(okAction2)
        present(saveConfirmAlert2, animated: true, completion: nil)
    }
    
  
    @IBAction func actionCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
