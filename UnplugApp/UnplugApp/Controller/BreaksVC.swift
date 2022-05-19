//
//  BreaksVC.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//
import UIKit

class BreaksVC: UITableViewController  {

    @IBOutlet weak var noBreaksLabel: UILabel!
    
    let breaks: [BreakItem] = [
        BreakItem(name: "Lunch", breakLength: "60 mins", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Shop", breakLength: "35 mins", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Coffee", breakLength: "5 mins", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "School Run", breakLength: "45 mins", timeOfDay: "2", reminder: "15", colour: "black")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if breaks.count < 1 {
//        noBreaksLabel.isEnabled = true
//        }
        //TODO: When the break nib is created, have a default one for no breaks
    }
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breaks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breakItem = breaks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "breakItemCell", for: indexPath)
        cell.textLabel?.text = breakItem.name
        cell.detailTextLabel?.text = breakItem.breakLength
        //TODO: Need to figure out how this will be stored and returned. Time convertion class?
        
        return cell
    }
}
