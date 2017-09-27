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
        let nameToSave:String = nameTextField.text!
        let desgToSave:String = desgTextField.text!
        let rateToSave:String = rateTextField.text!
        
        if(editMode){
            updateUserToDB(name: nameToSave, desg: desgToSave, rate: rateToSave)
        }
        
        else{
            addUserToDB(name: nameToSave, desg: desgToSave, rate: rateToSave)
        }
        
        if(editMode){
            self.navigationController?.popViewController(animated: true)
        }
            
        else{
            dismiss(animated: true, completion: nil)
        }
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
        
        if(editMode){
            self.navigationController?.popViewController(animated: true)
        }
        
        else{
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    private func updateSaveButtonState(){
        
    let text = nameTextField.text ?? ""
        //print (!test.isEmpty)
    saveButton.isEnabled = !text.isEmpty
    
    
    }
    
    
    func updateUserToDB(name:String, desg:String, rate:String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let searchName = incomingName
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Person")
        let predicate = NSPredicate(format: "name = '\(searchName)'")
        fetchRequest.predicate = predicate
        do{
            let test = try context.fetch(fetchRequest) as? [NSManagedObject]
            //if test!.count == 1
            //{
                let objectUpdate = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)
                objectUpdate.setValue(name, forKey: "name")
                objectUpdate.setValue(desg, forKey: "desg")
                objectUpdate.setValue(rate, forKey: "rate")
                do{
                    try context.save()
                    print("Data updated")
                }
                catch
                {
                    print(error)
                }
            //}
            
        }
        catch
        {
            print(error)
        }
        
        
    }
    
    
    func addUserToDB(name:String, desg:String, rate:String){
        
        //---saving to database ---//
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: context)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: context)
        
        person.setValue(name, forKeyPath: "name")
        person.setValue(desg, forKey: "desg")
        person.setValue(rate, forKeyPath: "rate")
        
        do
        {
            try context.save()
            print("succesfully saved to database")
        }
            
        catch let error as NSError {
            print("Error!! Could not save. \(error), \(error.userInfo)")
        }
        //---end of saving to database --//
    }
    
       
    

}
