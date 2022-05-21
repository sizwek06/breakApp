//
//  BreaksVC.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//
import UIKit

class BreaksViewController: UITableViewController  {
    
    let breaksArray: [BreakItem] = [
        BreakItem(name: "Lunch", breakLength: 60, timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Shop", breakLength: 35, timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Coffee", breakLength: 5, timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "School Run", breakLength: 45, timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Special Break", breakLength: 1, timeOfDay: "2", reminder: "15", colour: "black")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "BreakItemCell", bundle: nil), forCellReuseIdentifier: "breakItemCellId")
        
        tableView.layer.cornerRadius = 30
        tableView.separatorEffect = .none
    }
    
}

//MARK: - TableView DataSource
extension BreaksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breaksArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breakItem = breaksArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "breakItemCellId", for: indexPath) as! BreakItemCell
        //TODO: make this into a guard let
        cell.breakNameLabel?.text = breakItem.name
        cell.breakDurationLabel?.text = "\(breakItem.breakLength) mins"
        //TODO: Need to figure out how this will be stored and returned. Time convertion class?
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBreakItem", sender: self)
    }
}

//MARK: - Segue with time
extension BreaksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let breakVC = segue.destination as! BreakItemViewController
        //TODO: make this into a guard let
        if let indexPath = tableView.indexPathForSelectedRow {
            breakVC.defaultTime = breaksArray[indexPath.row].breakLength
            breakVC.breakName = breaksArray[indexPath.row].name
        }
    }
}
