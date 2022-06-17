//
//  BreaksVC.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//
import UIKit

class BreaksViewController: UITableViewController  {
    
    var currentCount: Int?
    var initialBreakTime: Int?
    var timer = Timer()
    var timeLeft = 0
    
    var stopTimerDelegate: StopTimerDelegate?
    var countDownDelegate: CountDownBeganDelegate?
    var shapeLayer: CAShapeLayer!
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
        timeLeft = breakItem.breakLength * 60
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BreakItem.cellItemIdKey, for: indexPath) as! BreakItemCell
        
        //TODO: make this into a guard let
        cell.breakNameLabel?.text = breakItem.name
        cell.breakDurationLabel?.text = updateCountdown(timeLeft)
        cell.countDownView.layer.addSublayer(setupCircleLayers(withView: cell))
        
        //TODO: Need to figure out how this will be stored and returned. Time convertion class?
        //countdownView.layer.addSublayer(setupCircleLayers())
        cell.selectionStyle = .none
        cell.configureCell(with: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.showBreakItemSegue, sender: self)
        currentIndexPath = indexPath
        self.initialBreakTime = breaksArray[indexPath.row].breakLength
    }
    
    func updateCountdown(_ timeLeft: Int) -> String {
        return String(format: "%02d:%02d:%02d", 0, timeLeft / 60, timeLeft % 60)
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
    
    func countDownStarted(count: String, countInt: Int, timer: Timer) {
        self.currentCount = countInt
        //TODO: Update the cell's look to indicate active?
        
        breaksArray[currentIndexPath.row].breakLength = countInt / 60
        
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

//MARK: - Progress Bar
extension BreaksViewController {
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, withView: UIView) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: 30,
                                        startAngle: 0 * CGFloat.pi, endAngle: 2.25 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 7
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = CGPoint(x: 325, y: 50)
        return layer
    }
    
    private func setupCircleLayers(withView: UIView) -> CALayer {
        let trackLayer = createCircleShapeLayer(strokeColor: .orange, fillColor: Constants.backgroundColor, withView: withView)
        withView.layer.addSublayer(trackLayer)
         
        shapeLayer = createCircleShapeLayer(strokeColor: Constants.outlineStrokeColor, fillColor: Constants.trackStrokeColor, withView: withView)
        shapeLayer.transform = CATransform3DMakeRotation(0 / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 50
        return shapeLayer
    }
}
