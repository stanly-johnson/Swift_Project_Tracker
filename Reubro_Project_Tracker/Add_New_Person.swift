//
//  Add_New_Person.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 22/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData

class Add_New_Person: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var desgTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionSaveButton(_ sender: Any) {
        let nameToSave = nameTextField.text
        let desgToSave = desgTextField.text
        let rateToSave = rateTextField.text
        
        //---saving to database ---//
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: context)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: context)
        
        person.setValue(nameToSave, forKeyPath: "name")
        person.setValue(desgToSave, forKey: "desg")
        person.setValue(rateToSave, forKeyPath: "rate")
        
        do
        {
            try context.save()
            print("saved")
        }
            
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        //---end of saving to database --//

    }
    
    
    
    
    @IBAction func actionCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
