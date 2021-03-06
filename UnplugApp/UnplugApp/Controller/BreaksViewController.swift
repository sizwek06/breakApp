//
//  BreaksVC.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//
import UIKit

class BreaksViewController: UITableViewController  {
    
    var currentCount: String?
    var initialBreakTime: String?
    var timer = Timer()
    
    var stopTimerDelegate: StopTimerDelegate?
    var countDownDelegate: CountDownBeganDelegate?
    
    var currentIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "BreakItemCell", bundle: nil), forCellReuseIdentifier: BreakItem.cellItemIdKey)
        
        tableView.layer.cornerRadius = 0
        tableView.separatorEffect = .none
        
        tableView.reloadData()
    }
    
    @IBAction func refreshClicked(_ sender: UIBarButtonItem) {
        print("refresh clicked")
        reloadTable()
    }
}

//MARK: - TableView DataSource
extension BreaksViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breaksArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breakItem = breaksArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BreakItem.cellItemIdKey, for: indexPath) as! BreakItemCell
        //TODO: make this into a guard let
        cell.breakNameLabel?.text = breakItem.name
        cell.breakDurationLabel?.text = "Time Remaining: \(breakItem.breakLength) min(s)"
        //TODO: Need to figure out how this will be stored and returned. Time convertion class?
        
        cell.selectionStyle = .none
        cell.configureCell(with: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.showBreakItemSegue, sender: self)
        currentIndexPath = indexPath
        self.initialBreakTime = breaksArray[indexPath.row].breakLength
    }
}

//MARK: - Segue Section
extension BreaksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.showBreakItemSegue {
            guard let breakItemViewController = segue.destination as? BreakItemViewController else { return }
            
            breakItemViewController.countDownDelegate = self
            breakItemViewController.closeViewDelegate = self
            
            if let indexPath = tableView.indexPathForSelectedRow {
                breakItemViewController.breakArrayIndex = indexPath.row
                breakItemViewController.defaultTime = Int(breaksArray[indexPath.row].breakLength)
                breakItemViewController.breakName = breaksArray[indexPath.row].name
            }
        }
        
        if segue.identifier == Constants.addBreakItemSegue {
            guard let addBreakViewController = segue.destination as? AddBreakViewController else { return }
            
            addBreakViewController.countDownDelegate = self
            addBreakViewController.closeViewDelegate = self
            
            shouldPerformSegue(withIdentifier: Constants.addBreakItemSegue, sender: Any?.self)
        }
    }
}

//MARK: BreakItemViewController - CountDownDelegate
extension BreaksViewController: CountDownBeganDelegate {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func resetTimeValue() {
        breaksArray[currentIndexPath.row].breakLength = self.initialBreakTime!
    }
    
    func countDownStarted(count: String, timer: Timer) {
        self.currentCount = count
        //TODO: Update the cell's look to indicate active?
        
        breaksArray[currentIndexPath.row].breakLength = count
        
        //TODO: highlight the current cell?
        tableView.reloadData()
    }
}

//MARK: BreakItemViewController - CloseViewDelegate
extension BreaksViewController: CloseViewDelegate {
    func didSelectClose(_ viewController: UIViewController) {
        self.dismiss(animated: true)
    }
}
