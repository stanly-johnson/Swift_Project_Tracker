//
//  ViewController.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        @IBOutlet var tableView: UITableView!
        var items: [String] = ["Memmbles", "Chronic Compass", "Swift"]
        var activity: [Int] = [1,1,0]
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HomeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell
            else {
            fatalError("The dequeued cell is not an instance of ProjectTableViewCell.")
                }
        
        let name = items[indexPath.row]
        let status = activity[indexPath.row]
        
        if status == 0
        {
            cell.nameStatusOfProject.textColor = UIColor.black
        }
        
        else
        {
           cell.nameStatusOfProject.textColor = UIColor.blue
        }
        
        cell.nameStatusOfProject.text = name;
        
        return cell
    }
    
    
}


