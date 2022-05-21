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
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    
    var timer = Timer()
    var secondsPassed = 0
    var defaultTime: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 20
        
        if let breakTime = defaultTime {
            self.secondsPassed = breakTime * 10
            updateCountdown(secondsPassed)
        }
        
        quoteManager.delegate = self
        quoteManager.getQuote()
    }
    
    @objc func updateTimer() {
        if secondsPassed != 0 {
            secondsPassed -= 1
            updateCountdown(secondsPassed)
        } else {
            timer.invalidate()
            updateButtonTitle("START")
            //TODO: Add a message once the break is over
        }
    }
    
    func updateCountdown(_ timeLeft: Int) {
        countDownLabel?.text = String(format: "%02d:%02d:%02d", 0, timeLeft / 60, timeLeft % 60)
    }
    
    func updateButtonTitle(_ currentTitle: String) {
        startButton.setTitle(currentTitle, for: .normal)
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "STOP" {
                timer.invalidate()
                updateButtonTitle("START")
            } else if buttonTitle == "START" {
                updateButtonTitle("STOP")
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        present(deleteAlert.showDeleteAlert(), animated: true, completion: nil)
    }
    
}

//MARK: - QuoteManagerDelegate
extension BreakItemViewController: QuoteManagerDelegate {
    func didUpdateCurrentQuote(_ quoteManager: QuoteManager, quoteModel: QuoteModel) {
        self.quoteLabel.text = "\(quoteModel.text) \n\n\(quoteModel.author ?? "~")"
        print("\(quoteModel.text) \n \(quoteModel.author ?? "~")")
        //TODO: REMOVE: Print is for testing purposes - quoteLabel word wrap
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
