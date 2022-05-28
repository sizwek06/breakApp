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
    
    var quoteManager = QuoteManager()
    let deleteAlert = DeleteBreakController()
    var countDownDelegate: CountDownBeganDelegate? = nil
    
    @IBOutlet weak var deleBarButton: UIBarButtonItem!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var quoteLoadingActivityIndicator: UIActivityIndicatorView!
    
    var timer = Timer()
    var secondsPassed = 0
    var defaultTime: Int?
    var breakName: String?
    
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
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
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
        } else {
            timer.invalidate()
            updateButtonTitle("START")
            //TODO: Add a message once the break is over
            
            countDownDelegate?.resetTimeValue()
        }
    }
    
    func updateCountdown(_ timeLeft: Int) -> String{
        return String(format: "%02d:%02d:%02d", 0, timeLeft / 60, timeLeft % 60)
    }
    
    func updateButtonTitle(_ currentTitle: String) {
        startButton.setTitle(currentTitle, for: .normal)
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "STOP" {
                timer.invalidate()
                updateButtonTitle("START")
                countDownDelegate?.countDownStarted(count: "\(defaultTime!) min(s)", timer: self.timer)
                countDownDelegate?.resetTimeValue()
            } else if buttonTitle == "START" {
                timer.invalidate()
                updateButtonTitle("STOP")
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    @IBAction func deleteBarButtonClicked(_ sender: Any) {
        present(deleteAlert.showDeleteAlert(breakName!), animated: true, completion: nil)
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
        
        if segue.identifier == "editButtonSegue" {
            let editbreaksViewController = segue.destination as! AddBreakViewController
            //TODO: make this into a guard let
            
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
