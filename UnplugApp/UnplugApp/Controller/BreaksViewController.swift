//
//  BreaksVC.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//
import UIKit

class BreaksViewController: UITableViewController  {
    
    @IBOutlet weak var testLabel: UILabel!
    
    var currentCount: String?
    
    weak var delegate: CountDownBeganDelegate? = nil
    var currentIndexPath = IndexPath()
    
     var breaksArray: [BreakItem] = [
        BreakItem(name: "Lunch", breakLength: "60", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Shop", breakLength: "35", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Coffee", breakLength: "5", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "School Run", breakLength: "45", timeOfDay: "2", reminder: "15", colour: "black"),
        BreakItem(name: "Special Break", breakLength: "1", timeOfDay: "2", reminder: "15", colour: "black")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "BreakItemCell", bundle: nil), forCellReuseIdentifier: "breakItemCellId")
        
        tableView.layer.cornerRadius = 30
        tableView.separatorEffect = .none
        delegate = self
        
        tableView.reloadData()
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
        cell.configureCell(with: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBreakItem", sender: self)
        currentIndexPath = indexPath
        print(currentIndexPath)
    }
}

//MARK: - Segue with time
extension BreaksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let breaksViewController = segue.destination as! BreakItemViewController
        breaksViewController.countDownDelegate = self
        //TODO: make this into a guard let
        if let indexPath = tableView.indexPathForSelectedRow {
            breaksViewController.defaultTime = Int(breaksArray[indexPath.row].breakLength)
            breaksViewController.breakName = breaksArray[indexPath.row].name
        }
    }
}

//MARK: BreakItemViewController - DataEnteredDelegate
extension BreaksViewController: CountDownBeganDelegate {
    
    func countDownStarted(count: String) {
        self.currentCount = count
        //TODO: Update the cell
        
        breaksArray[currentIndexPath.row].breakLength = count
        
        //TODO: highlight the current cell?
        tableView.reloadData()
    }
}
