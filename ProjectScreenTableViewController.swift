//
//  ProjectScreenTableViewController.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 20/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import os.log

class ProjectScreenTableViewController: UITableViewController {
    
    
    
    var data : [String] = ["One","Two"]
    var nameProject = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Projects"
        
        
        print(nameProject)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProjectTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProjectTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProjectTableViewCell.")
        }
        
        let names = data[indexPath.row]
        cell.nameLabel.text = names;

        return cell
    }
    

    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
       
      
        //if let sourceViewController = sender.sourceViewController as? Add_New_Project, nameProject = sourceViewController.nameProject {
        
            let newIndexPath = IndexPath(row: data.count, section: 0)
            data.append(nameProject)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        //}

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
            
        case "ShowItem":
            guard let Add_New_Project = segue.destination as? Add_New_Project else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? ProjectTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = data[indexPath.row]
            //destinationViewController.nameOfProject.text = selectedMeal
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            


            }
        

    }
    

}
