//
//  ViewController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//

import UIKit

class BreakItemViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
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
    }
    
    @objc func updateTimer() {
        if secondsPassed != 0 {
            secondsPassed -= 1
            updateCountdown(secondsPassed)
        } else {
            timer.invalidate()
            //TODO: Add a message once the break is over
        }
    }
    
    func updateCountdown(_ timeLeft: Int) {
        countDownLabel?.text = String(format: "%02d:%02d:%02d", 0, timeLeft / 60, timeLeft % 60)
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @IBAction func startBtnClicked(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
}

