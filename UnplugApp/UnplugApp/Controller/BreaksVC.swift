//
//  BreaksVC.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//
import UIKit

class BreaksVC: UITableViewController  {
    
    let breaksArray: [BreakItem] = [
        BreakItem(name: "Lunch", breakLength: "60", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Shop", breakLength: "35", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Coffee", breakLength: "5", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "School Run", breakLength: "45", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Special Break", breakLength: "5", timeOfDay: "2", reminder: "15", colour: "black")
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
        return breaksArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breakItem = breaksArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "breakItemCell", for: indexPath)
        cell.textLabel?.text = breakItem.name
        cell.detailTextLabel?.text = "\(breakItem.breakLength) mins"
        //TODO: Need to figure out how this will be stored and returned. Time convertion class?
        
        return cell
    }
    
    //MARK: - Segue with time
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBreakItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let breakVC = segue.destination as! BreakItemVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let breakTime = breaksArray[indexPath.row].breakLength
            breakVC.defaultTime = breakTime
        }
    }
}
