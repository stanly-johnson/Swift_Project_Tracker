//
//  Add_New_Person.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 22/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData


class Add_New_Person: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var desgTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    var editMode : Bool = false
    var incomingName : String?
    var incomingRate : String?
    var incomingDesg : String?
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var people: [NSManagedObject] = []
    var detail: Person_Detail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        
        ///--code to prefill data if it is edit mode
        if(editMode){
            
            nameTextField.text = incomingName
            desgTextField.text = incomingDesg
            rateTextField.text = incomingRate
        }
        ///--------
        
        
        updateSaveButtonState()

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
            print("succesfully saved to database")
        }
            
        catch let error as NSError {
            print("Error!! Could not save. \(error), \(error.userInfo)")
        }
        
        //---end of saving to database --//
        
        dismiss(animated: true, completion: nil)

    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = nameTextField.text
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }

    
    
    @IBAction func actionCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateSaveButtonState(){
        
    let text = nameTextField.text ?? ""
        //print (!test.isEmpty)
    saveButton.isEnabled = !text.isEmpty
    
    
    }
    
       
    

}
