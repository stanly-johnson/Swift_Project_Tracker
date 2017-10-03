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
    let person_count = 2
    
    var project_name = String()
    var client_name = String()
    
    //----code only for testing purposes
    
    let test_names = ["Stanly","Oommen"]
    let test_module = ["Design","Develop"]
    let test_hours = ["5","8"]
    let test_cost = ["2500","3000"]
    
    
    ////----uncomment only when necessary
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            
            cell.nameLabel.text = test_names[indexPath.row]
            cell.moduleLabel.text = test_module[indexPath.row]
            cell.hourLabel.text = "\(test_hours[indexPath.row]) hrs"
            cell.costLabel.text = "\(test_cost[indexPath.row]) Rs"
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
