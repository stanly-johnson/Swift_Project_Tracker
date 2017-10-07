//
//  Add_New_Project.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 27/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//  Written by Stanly Johnson

import UIKit
import CoreData

class Add_New_Project: UITableViewController, UITextFieldDelegate {
    
    let section_title = ["General","People","Sechdule","Cost","Status"]
    let items = [["Project Name","Client Name"],["Person-One","Person-Two"], ["Start Date","End Date","Hours"], ["Est Cost"], ["Completed/Closed"]]
    var person_count = 0
    var people_assigned:[NSManagedObject] = []
    var editMode : Bool = false
    var viewMode : Bool = false
    var total_cost : Int = 0
    var searchName = String()
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //var newProject = projectDetails()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(editMode)
        {
            fillvalues()
            searchName = newProject.projectName
            title = newProject.projectName
            if (viewMode)
            {
                saveButton.isEnabled = false
            }
        }
            
            
        else
        {
            newProject.projectName = ""
            newProject.clientName = ""
            newProject.time.end_date = ""
            newProject.time.start_date = ""
            newProject.time.hours_project = ""
            newProject.est_cost = ""
            newProject.closed = false
            newProject.completed = false
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromDB()
        self.tableView.reloadData()
        if(editMode)
        {
            refresh()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       return section_title.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              
        if section == 1
        {
            fetchFromDB()
            return person_count
        }
        
        else
        {
        return self.items[section].count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section_title[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1
        // people section - shows the person,module,hours and cost
        {
            let reuseIdentifier = "PersonCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PersonCell  else {
                fatalError("The dequeued cell is not an instance of PersonCell.")
            }
            
            fetchFromDB()
            let displayName = people_assigned[indexPath.row]
            let project_fetched_name = displayName.value(forKeyPath: "personName") as? String
            cell.nameLabel.text = project_fetched_name
            cell.moduleLabel.text = displayName.value(forKeyPath: "module") as? String
            let hour_label_text = (displayName.value(forKeyPath: "hours") as? String)!
            cell.hourLabel.text = "\(hour_label_text) hrs"
            let cost_label_text = (displayName.value(forKeyPath: "rate") as? String)!
            cell.costLabel.text = "\(cost_label_text) Rs"
           
            return cell
        }
        
        if indexPath.section == 2
        {
            let reuseIdentifier = "AddNewProject"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AddNewProjectTableViewCell  else {
                fatalError("The dequeued cell is not an instance of AddNewProjectTableViewCell.")
            }
            
            cell.displayLabel.text = items[indexPath.section][indexPath.row]
            cell.textField.isUserInteractionEnabled = false
            return cell
        }
        
        if indexPath.section == 0
        {
            let reuseIdentifier = "AddNewProject"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AddNewProjectTableViewCell  else {
                fatalError("The dequeued cell is not an instance of AddNewProjectTableViewCell.")
            }
            
            cell.displayLabel.text = items[indexPath.section][indexPath.row]
            
            if  (indexPath.row == 0)
            {
            cell.textField.text = newProject.projectName
            }
            
            if  (indexPath.row == 1)
            {
                cell.textField.text = newProject.clientName
            }
            
            
            return cell
        }
        
        if indexPath.section == 4
        {
            let reuseIdentifier = "StatusCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? StatusCell  else {
                fatalError("The dequeued cell is not an instance of StatusCell.")
            }
            
            if (newProject.completed)
            {
                cell.completedSwitch.setOn(true, animated: true)
            }
            
            if (newProject.closed)
            {
                cell.closedSwitch.setOn(true, animated: true)
            }
            
            
            return cell
        }
            
            
        else
        {
            let reuseIdentifier = "AddNewProject"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AddNewProjectTableViewCell  else {
                fatalError("The dequeued cell is not an instance of AddNewProjectTableViewCell.")
            }
            
            cell.displayLabel.text = items[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //calling this delegate to set custom height for the status section
        
        if indexPath.section == 4
        {
            //status section height set to 100
            return 100
        }
        
        else
        {
            //all other sections have row height set to 60
            return 60
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1
        {
            let header = tableView.dequeueReusableCell(withIdentifier: "People_Section_Header")! as! People_Section_Header
            return header.contentView
        }
            
        if section == 2
        {
            let header = tableView.dequeueReusableCell(withIdentifier: "Sechdule_Section_Header")! as! Sechdule_Section_Header
            return header.contentView
        }
            
        if section == 3
        {
            let header = tableView.dequeueReusableCell(withIdentifier: "Cost_Section_Header")! as! Cost_Section_Header
            return header.contentView
        }
        
        if section == 4
        {
            let header = tableView.dequeueReusableCell(withIdentifier: "Status_Section_Header")! as! Status_Section_Header
            return header.contentView
        }
        
        else
        {
            let header = tableView.dequeueReusableCell(withIdentifier: "General_Section_Header")! as! General_Section_Header
            return header.contentView
        }
    }
    
  
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let nameCell = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as Any) as? AddNewProjectTableViewCell
        newProject.projectName = (nameCell?.textField.text)!
        print("project-name is \(newProject.projectName)")
        
        let clientCell = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as Any) as? AddNewProjectTableViewCell
        newProject.clientName = (clientCell?.textField.text)!
        print("client-name is \(newProject.clientName)")
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if(indexPath.section == 1)
        {
            return true
        }
        
        else
        {
            return false

        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let index = indexPath.row
        
        if editingStyle == .delete {
            managedObjectContext.delete(people_assigned[indexPath.row])
            
            do {
                try managedObjectContext.save()
                self.tableView.reloadData()
                
            }
                
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }

    
    
    
    func refresh(){
        
        calc_total_cost()
        let costCell = (tableView.cellForRow(at: IndexPath(row: 0 , section: 3)) as Any) as? AddNewProjectTableViewCell
        costCell?.textField.text = String(total_cost)
        
        let startDateCell = (tableView.cellForRow(at: IndexPath(row: 0 , section: 2)) as Any) as? AddNewProjectTableViewCell
        startDateCell?.textField.text = newProject.time.start_date
        
        let endDateCell = (tableView.cellForRow(at: IndexPath(row: 1 , section: 2)) as Any) as? AddNewProjectTableViewCell
        endDateCell?.textField.text = newProject.time.end_date
        
        let hoursProjectCell = (tableView.cellForRow(at: IndexPath(row: 2 , section: 2)) as Any) as? AddNewProjectTableViewCell
        hoursProjectCell?.textField.text = newProject.time.hours_project
    }
    
    
    func fillvalues(){
        
        //rest of the data is being filled from the cellForRowAt method
        //lousy coding -- but will have to do for now
        
        let startDateCell = (tableView.cellForRow(at: IndexPath(row: 0 , section: 2)) as Any) as? AddNewProjectTableViewCell
        startDateCell?.textField.text = newProject.time.start_date
        
        let endDateCell = (tableView.cellForRow(at: IndexPath(row: 1 , section: 2)) as Any) as? AddNewProjectTableViewCell
        endDateCell?.textField.text = newProject.time.end_date
        
        let hoursProjectCell = (tableView.cellForRow(at: IndexPath(row: 2 , section: 2)) as Any) as? AddNewProjectTableViewCell
        hoursProjectCell?.textField.text = newProject.time.hours_project
        
    }
    
    
    
    //MARK: - Database
    
    func insertToDB()
    {
        //---saving to database ---//
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Project",
                                       in: context)!
        
        let project = NSManagedObject(entity: entity,
                                     insertInto: context)
        
          project.setValue(newProject.projectName, forKeyPath: "name")
          project.setValue(newProject.clientName, forKey: "client")
          project.setValue(newProject.time.start_date, forKey: "startDate")
          project.setValue(newProject.time.end_date, forKey: "endDate")
          project.setValue(newProject.time.hours_project, forKey: "hours")
          project.setValue(newProject.closed, forKey: "closed")
          project.setValue(newProject.completed, forKey: "completed")
                
        do
        {
            try context.save()
            print("Succesfully added the project to database")
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Project")
        fetchRequest.predicate = NSPredicate(format : "name contains[c] %@", searchName)
        
       do
       {
        
            let test_project = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        
            if(test_project!.count == 1)
                {
                        let project = test_project![0]
                        project.setValue(newProject.projectName, forKeyPath: "name")
                        project.setValue(newProject.clientName, forKey: "client")
                        project.setValue(newProject.time.start_date, forKey: "startDate")
                        project.setValue(newProject.time.end_date, forKey: "endDate")
                        project.setValue(newProject.time.hours_project, forKey: "hours")
                        project.setValue(newProject.closed, forKey: "closed")
                        project.setValue(newProject.completed, forKey: "completed")
        
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
    
    
    func fetchFromDB() //fetching from person assigned
        //soon to be replaced
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest <NSFetchRequestResult>(entityName : "PersonAssigned")
        request.predicate = NSPredicate(format : "projectName contains[c] %@", newProject.projectName)
        request.returnsObjectsAsFaults = false
        do
        {
            people_assigned = try context.fetch(request) as! [NSManagedObject]
            if people_assigned.count > 0
            {
                //nothing much to do here
            }            
            
        }
        catch
        {
            print("Fetch operation failed")
        }
            
        
        person_count = people_assigned.count
        
    }
    
    func calc_total_cost()
    {
        total_cost = 0
        fetchFromDB()
        for row in 0...person_count-1
        {
                let displayName = people_assigned[row]
                let cost_label_text = (displayName.value(forKeyPath: "rate") as? String)!
                total_cost = total_cost + Int(cost_label_text)!
        }
        
    }
    

 
    // MARK: - Navigation
    
    @IBAction func actionCancelButton(_ sender: Any) {
        
        if(editMode)
        {
            self.navigationController?.popViewController(animated: true)
        }
        
        else
        {
        dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func actionSaveButton(_ sender: Any) {
        
        refresh()
        if newProject.projectName.isEmpty
        {
            emptyProjectName()
        }
        
        else
        {
            if (editMode)
            {
                updateToDB()
            }
            
            else
            {
                insertToDB()
            }
        }
        
        if(editMode)
        {
            self.navigationController?.popViewController(animated: true)
        }
            
        else
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
 
    @IBAction func actionAssignPerson(_ sender: Any) {
        if newProject.projectName.isEmpty
        {
            emptyProjectName()
        }
            
        else
        {
            performSegue(withIdentifier: "assignPersonSegue", sender: sender)
        }
    }
    
    
    @IBAction func actionAddSchedule(_ sender: Any) {
        
        if newProject.projectName.isEmpty
        {
            emptyProjectName()
        }
            
        else
        {
            performSegue(withIdentifier: "scheduleSegue", sender: sender)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "assignPersonSegue":
            let destinationNavigationController = segue.destination as! UINavigationController
            let selectedViewController = destinationNavigationController.topViewController as! People_In_Project
            selectedViewController.selectedProject = newProject.projectName
            
        case "scheduleSegue":
            let destinationNavigationController = segue.destination as! UINavigationController
            let selectedViewController = destinationNavigationController.topViewController as! ScheduleEdit
            selectedViewController.selectedProject = newProject.projectName
            
        case "PersonEdit":
            let destinationNavigationController = segue.destination as! UINavigationController
            let selectedViewController = destinationNavigationController.topViewController as! People_In_Project
            
            guard let selectedTableCell = sender as? PersonCell else {
                fatalError("Unexpected sender -- table cell \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTableCell) else {
                fatalError("The selected cell is not in table")
            }
            let person = people_assigned[indexPath.row]
            selectedViewController.editMode = true
            selectedViewController.selectedProject = newProject.projectName
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }


    
    
    // MARK: - Alerts
    
    func emptyProjectName()
    {
        let alert = UIAlertController(title: "Warning", message: "Project name cannot be left blank", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .destructive){ (action:UIAlertAction!) in
            //self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
  
    

}
