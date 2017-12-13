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

class People_In_Project: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
   
    @IBOutlet weak var moduleTextField: UITextField!
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var personPicker: UIPickerView!
    
    @IBOutlet weak var selectPersonLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    var pickerData: [String] = [String]()
    var person:[NSManagedObject] = []
    var fetch_count = 0
    var editMode : Bool = false
    
    let max_hours = 50 //change this value to change the max hours shown with picker view
    var startDate = String()
    var endDate = String()
    var selectedHours = String()
    var selectedPerson = String()
    var selectedProject = String()
    var fetch_rate = String()
    var cost = String()
    var incoming_person_name = String()
    var module_name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFromDB()
        title = selectedProject
        self.moduleTextField.delegate = self
        self.hourPicker.delegate = self
        
        
        if (editMode)
        {
            personPicker.isHidden = true
            selectPersonLabel.text = incoming_person_name
            selectedPerson = incoming_person_name
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d/M/yy"
            if let convertedStartDate = dateFormatter.date(from: startDate) {
                startDatePicker.setDate(convertedStartDate, animated: false)
            }
            if let convertedEndDate = dateFormatter.date(from: endDate) {
                endDatePicker.setDate(convertedEndDate, animated: false)
            }
            moduleTextField.text = module_name
            hourPicker.selectRow(Int(selectedHours)!+1, inComponent: 0, animated: false)
            
            
        }
        
        else
        {
            startDatePicker.setDate(Date(), animated: false)
            endDatePicker.setDate(Date(), animated: false)
            startDate = ""
            endDate = ""
            module_name = ""
            selectedHours = ""
        }
        
        
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
            return max_hours
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == hourPicker
        {
            selectedHours = String(pickerView.selectedRow(inComponent: 0) + 1)

        }
        
        if pickerView == personPicker
        {
            let count  = pickerView.selectedRow(inComponent: 0)
            selectedPerson = pickerData[count]
            
        }
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
    
    
    //MARK: - Database
    
    func fetchFromDB()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest <NSFetchRequestResult>(entityName : "Person")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [sortDescriptor]
        
        do
        {
            person = try context.fetch(request) as! [NSManagedObject]
            if person.count > 0
            {
                for row in 0...person.count-1
                {
                let displayName = person[row]
                let fetch_name = displayName.value(forKeyPath: "name") as? String
                fetch_rate = (displayName.value(forKeyPath: "rate") as? String)!
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
    
    
    func insertIntoDB()
    {
        //---saving to database ---//
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "PersonAssigned",
                                       in: context)!
        let person = NSManagedObject(entity: entity,
                                      insertInto: context)
        
        
        person.setValue(startDate, forKey: "startDate")
        person.setValue(endDate, forKey: "endDate")
        person.setValue(selectedHours, forKey: "hours")
        person.setValue(moduleTextField.text, forKey: "module")
        person.setValue(selectedPerson, forKey:"personName")
        person.setValue(selectedProject, forKey: "projectName")
        let calc = String(Int(selectedHours)! * Int(fetch_rate)!)
        person.setValue(calc, forKey:"rate")
        
        do
        {
            try person.managedObjectContext?.save()
            print("succesfully added the person to project")
        }
            
        catch let error as NSError {
            print("Error!! Could not save. \(error), \(error.userInfo)")
        }
        //---end of saving to database --//
    }
    
    func updateToDB()
    {
        //---saving to database ---//
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonAssigned")
        fetchRequest.predicate = NSPredicate(format : "(personName contains[c] %@)AND(projectName contains[c] %@)", incoming_person_name,selectedProject)
        
        do
        {
            
            let test_person = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if(test_person!.count == 1)
            {
                let person = test_person![0]
                person.setValue(startDate, forKey: "startDate")
                person.setValue(endDate, forKey: "endDate")
                person.setValue(selectedHours, forKey: "hours")
                person.setValue(moduleTextField.text, forKey: "module")
                person.setValue(selectedPerson, forKey:"personName")
                person.setValue(selectedProject, forKey: "projectName")
                let calc = String(Int(selectedHours)! * Int(fetch_rate)!)
                person.setValue(calc, forKey:"rate")
                
                do
                {
                    try managedContext.save()
                    print("Succesfully edited project in database")
                }
                    
                catch let error as NSError {
                    print("Error!! Could not save. \(error), \(error.userInfo)")
                }
            }
        }
            
        catch
        {
            print(error)
        }
        
        //---end of saving to database --//
        
    }
    
    
    // MARK: - DatePicker
    
    @IBAction func actionStartDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        startDate = dateFormatter.string(from: startDatePicker.date)
        print ("Start Date set to \(startDate)")
        
    }
  
    
    @IBAction func actionEndDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        endDate = dateFormatter.string(from: endDatePicker.date)
        print ("End Date set to \(endDate)")
        
    }
    
    // MARK: - Navigation
    
    @IBAction func actionCancelButton(_ sender: Any) {
        
        if (editMode)
        {
            dismiss(animated: true, completion: nil)
        }
        
        else
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        if(editMode)
        {
            updateToDB()
        }
        
        else
        {
            insertIntoDB()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

}
