//
//  Add_New_Project.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 27/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//  Written by Stanly Johnson

import UIKit

class Add_New_Project: UITableViewController {
    
    let section_title = ["General","People","Sechdule","Cost","Status"]
    let items = [["Project Name","Client Name"],["Person-One","Person-Two"], ["Start Date","End Date","Hours"], ["Est Cost", "Total Cost"], ["Completed/Closed"]]
    let person_count = 2
    
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
            cell.costLabel.text = "\(test_cost[indexPath.row]) rs"
            //have to add the code for labels
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
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func actionCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
