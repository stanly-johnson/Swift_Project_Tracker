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
    var project_name = String()
    var client_name = String()
    
    //----code only for testing purposes
    
//    let test_names = ["Stanly","Oommen"]
//    let test_module = ["Design","Develop"]
//    let test_hours = ["5","8"]
//    let test_cost = ["2500","3000"]
//    
    
    ////----uncomment only when necessary
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromDB()
        self.tableView.reloadData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return section_title.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
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
        {
            let reuseIdentifier = "PersonCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PersonCell  else {
                fatalError("The dequeued cell is not an instance of PersonCell.")
            }
            
            fetchFromDB()
            let displayName = people_assigned[indexPath.row]
            cell.nameLabel.text = displayName.value(forKeyPath: "name") as? String
            cell.moduleLabel.text = displayName.value(forKeyPath: "module") as? String
            cell.hourLabel.text = "\(displayName.value(forKeyPath: "hours") as? String) hrs"
            cell.costLabel.text = "\(displayName.value(forKeyPath: "rate") as? String) Rs"
            //have to add the code for labels
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
        
        if indexPath.section == 4
        {
            let reuseIdentifier = "StatusCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? StatusCell  else {
                fatalError("The dequeued cell is not an instance of StatusCell.")
            }
            
            //have to add the code for switches
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
        let nameCell = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? Any) as? AddNewProjectTableViewCell
        project_name = (nameCell?.textField.text)!
        print("project-name is \(project_name)")
        let clientCell = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? Any) as? AddNewProjectTableViewCell
        client_name = (clientCell?.textField.text)!
        print("client-name is \(client_name)")

        
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
        
          project.setValue(project_name, forKeyPath: "name")
          project.setValue(client_name, forKey: "client")

        
        do
        {
            try context.save()
            print("succesfully added the project to database")
        }
            
        catch let error as NSError {
            print("Error!! Could not save. \(error), \(error.userInfo)")
        }
        //---end of saving to database --//
        
    }
    
    
    func fetchFromDB()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest <NSFetchRequestResult>(entityName : "PersonAssigned")
        request.returnsObjectsAsFaults = false
        
        do
        {
            people_assigned = try context.fetch(request) as! [NSManagedObject]
//            if people_assigned.count > 0
//            {
//                for row in 0...people_assigned.count-1
//                {
//                    let displayName = people_assigned[row]
//                    let fetch_name = displayName.value(forKeyPath: "name") as? String
//                    fetch_rate = (displayName.value(forKeyPath: "rate") as? String)!
//                    pickerData.append(fetch_name!)
//                }
//            }
            
        }
        catch
        {
            print("Fetch operation failed")
        }
        
        person_count = people_assigned.count
        
    }

 
    // MARK: - Navigation
    
    @IBAction func actionCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func actionSaveButton(_ sender: Any) {
        
        if project_name.isEmpty
        {
            emptyProjectName()
        }
        
        else
        {
            insertToDB()
        }
    }
    
 
    @IBAction func actionAssignPerson(_ sender: Any) {
        if project_name.isEmpty
        {
            emptyProjectName()
        }
            
        else
        {
            performSegue(withIdentifier: "assignPersonSegue", sender: sender)
        }
    }
    
    
    @IBAction func actionAddSchedule(_ sender: Any) {
        
        if project_name.isEmpty
        {
            emptyProjectName()
        }
            
        else
        {
            performSegue(withIdentifier: "scheduleSegue", sender: sender)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "assignPersonSegue":
            let destinationNavigationController = segue.destination as! UINavigationController
            let selectedViewController = destinationNavigationController.topViewController as! People_In_Project
            selectedViewController.selectedProject = project_name
            
        case "scheduleSegue":
            guard let selectedViewController = segue.destination as? ScheduleEdit else {
            fatalError("Unexpected Destination; \(segue.destination)")
        }
        
        selectedViewController.selectedProject = project_name
            
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
