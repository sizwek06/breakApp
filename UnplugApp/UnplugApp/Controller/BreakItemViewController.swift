//
//  ViewController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//

import UIKit

class BreakItemViewController: UIViewController {
    
    var quoteManager = QuoteManager()
    let deleteAlert = DeleteBreakController()
    var countDownDelegate: CountDownBeganDelegate? = nil
    
    @IBOutlet weak var deleBarButton: UIBarButtonItem!
    @IBOutlet weak var currentBreakLabel: UILabel!
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
        startButton.layer.cornerRadius = 20
        
        if let breakTime = defaultTime {
            self.secondsPassed = breakTime * 60
            countDownLabel?.text = updateCountdown(secondsPassed)
        }
        currentBreakLabel?.text = breakName
        quoteManager.delegate = self
        quoteManager.getQuote()
    }
    
    @objc func updateTimer() {
        if secondsPassed != 0 {
            secondsPassed -= 1
            countDownLabel?.text = updateCountdown(secondsPassed)
            countDownDelegate?.countDownStarted(count: updateCountdown(secondsPassed))
        } else {
            timer.invalidate()
            updateButtonTitle("START")
            //TODO: Add a message once the break is over
        }
    }
    
    func updateCountdown(_ timeLeft: Int) -> String{
        return String(format: "%02d:%02d:%02d", 0, timeLeft / 60, timeLeft % 60)
    }
    
    func updateButtonTitle(_ currentTitle: String) {
        startButton.setTitle(currentTitle, for: .normal)
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "STOP" {
                timer.invalidate()
                updateButtonTitle("START")
                countDownDelegate?.countDownStarted(count: "\(defaultTime!) min(s)")
            } else if buttonTitle == "START" {
                updateButtonTitle("STOP")
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
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
    }
}

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
