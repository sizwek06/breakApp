//
//  ViewController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//

import UIKit

class BreakItemViewController: UIViewController {
    
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarOutlet: UINavigationBar!
    
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    var quoteManager = QuoteManager()
    var countDownDelegate: CountDownBeganDelegate?
    var closeViewDelegate: CloseViewDelegate?
    
    @IBOutlet weak var countdownView: UIView!
    
    @IBOutlet var breakItemView: UIView!
    @IBOutlet weak var deleBarButton: UIBarButtonItem!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var quoteLoadingActivityIndicator: UIActivityIndicatorView!
    
    var timer = Timer()
    var secondsPassed = 0
    var defaultTime: Int?
    var breakName: String?
    var breakArrayIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteLoadingActivityIndicator.startAnimating()
        startButton.layer.cornerRadius = 10
        
        if let breakTime = defaultTime {
            self.secondsPassed = breakTime * 60
            countDownLabel?.text = updateCountdown(secondsPassed)
        }
        
        navBarTitle.title = breakName
        quoteManager.delegate = self
        quoteManager.getQuote()
        startButton.backgroundColor = Constants.trackStrokeColor
        countdownView.layer.addSublayer(setupCircleLayers())
        quoteLoadingActivityIndicator.color = Constants.outlineStrokeColor
    }
    
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 5 * 1, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 4)
        self.view.layer.cornerRadius = 30
        self.view.layer.masksToBounds = true
    }
    
    @objc func updateTimer() {
        if secondsPassed != 0 {
            secondsPassed -= 1
            countDownLabel?.text = updateCountdown(secondsPassed)
            countDownDelegate?.countDownStarted(count: updateCountdown(secondsPassed), timer: self.timer)
            
            let aHundredPercent = CGFloat(self.defaultTime! * 60)
            let currentPercent = CGFloat(((self.defaultTime! * 60) - self.secondsPassed))
            let strokePointPercent = currentPercent / aHundredPercent
            
            DispatchQueue.main.async {
                self.shapeLayer.strokeEnd = strokePointPercent
            }
        } else {
            timer.invalidate()
            updateButton("START")
            //TODO: Add a message once the break is over
            let breakOverPopUp = BreakAlertController(with: breakName!, andCondition: .complete)
            breakOverPopUp.closeViewDelegate = self
            //TODO: This the part Gugs dropped the omission bomb on you
            
            present(breakOverPopUp.showBreakAddedAlert(), animated: true)
            quoteManager.getQuote()
            countDownDelegate?.resetTimeValue()
            self.shapeLayer.strokeEnd = 0
        }
    }
    
    func updateCountdown(_ timeLeft: Int) -> String{
        return String(format: "%02d:%02d:%02d", 0, timeLeft / 60, timeLeft % 60)
    }
    
    func updateButton(_ currentTitle: String) {
        if startButton.backgroundColor == Constants.trackStrokeColor {
            startButton.backgroundColor = Constants.outlineStrokeColor
        } else {
            startButton.backgroundColor = Constants.trackStrokeColor
        }
        
        startButton.setTitle(currentTitle, for: .normal)
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "STOP" {
                timer.invalidate()
                countDownDelegate?.countDownStarted(count: "\(defaultTime!) min(s)", timer: self.timer)
                countDownDelegate?.resetTimeValue()
                self.shapeLayer.strokeEnd = 0
            } else if buttonTitle == "START" {
                DispatchQueue.main.async {
                    self.timer.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                }
            }
            updateButton(Constants.startButtonTitle(buttonCurrenTitle: sender.currentTitle!))
        }
    }
    
    @IBAction func deleteBarButtonClicked(_ sender: UIBarButtonItem) {
        if let currentArrayIndex = self.breakArrayIndex {
            let deletePopUp = BreakAlertController(with: breakName!)
            deletePopUp.countDownDelegate = countDownDelegate
            deletePopUp.closeViewDelegate = closeViewDelegate
            
            //4 AM Seez here, here we create the deletePopUp like this so we may apply the delegate method to itself
            //So that when the delete button is clicked in the next present, the delete AND reload table occurs
            present(deletePopUp.showDeleteAlertWithCurrentArrayIndex(currentArrayIndex), animated: true)
        }
    }
}

//MARK: BreakItemViewController - QuoteManagerDelegate
extension BreakItemViewController: QuoteManagerDelegate {
    func didUpdateCurrentQuote(_ quoteManager: QuoteManager, quoteModel: QuoteModel) {
        self.quoteLabel.text = "\(quoteModel.text) \n\n~ \(quoteModel.author ?? "Unknown") ~"
        quoteLoadingActivityIndicator.isHidden = true
    }
    
    func didFailWithError(error: Error) {
        print(error)
        quoteLoadingActivityIndicator.isHidden = true
    }
}

//MARK: - Edit Item Segue
extension BreakItemViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.editButtonSegue {
            guard let editbreaksViewController = segue.destination as? AddBreakViewController else { return }
            
            editbreaksViewController.reloadViewTitleDelegate = self
            
            editbreaksViewController.countDownDelegate = countDownDelegate
            editbreaksViewController.breakArrayIndex = breakArrayIndex
            editbreaksViewController.defaultTime = self.defaultTime
            editbreaksViewController.breakName = self.breakName
        }
    }
}

extension BreakItemViewController: StopTimerDelegate {
    func stopCountDown() {
        self.timer.invalidate()
    }
}

//MARK: - Progress Bar
extension BreakItemViewController {
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: 120,
                                        startAngle: 0.75 * CGFloat.pi, endAngle: 2.25 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 30
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = countdownView.center
        return layer
    }
    
    private func setupCircleLayers() -> CALayer {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: .clear)
        countdownView.layer.addSublayer(pulsatingLayer)
        
        let trackLayer = createCircleShapeLayer(strokeColor: Constants.trackStrokeColor, fillColor: Constants.backgroundColor)
        countdownView.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: Constants.outlineStrokeColor, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(0 / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        return shapeLayer
    }
}

extension BreakItemViewController: CloseViewDelegate {
    func didSelectClose(_ viewController: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BreakItemViewController: ReloadBreakDetailsDelegate {
    func refreshBreakDuration(_ breakDuration: Int) {
        countDownLabel?.text = updateCountdown(breakDuration * 60)
    }
    
    func refreshTitle(_ viewTitle: String) {
        navBarTitle.title = viewTitle
    }
}
