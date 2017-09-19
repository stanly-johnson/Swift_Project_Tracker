//
//  PeopleScreen.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class PeopleScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
       @IBOutlet weak var actionButtonNewPerson: UIButton!
   
    
    var items: [String] = ["Person One", "Person Two", "Person Three", "Person Four", "Person Five", "Person Six"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "celltwo")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "celltwo", for: indexPath)
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }

        @IBAction func actionNewPersonButton(_ sender: Any) {
             performSegue(withIdentifier: "newPersonSegue", sender: sender)
    }
    
}
