//
//  ViewController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//

import UIKit

class BreakItemVC: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    var timer = Timer()
    var secondsPassed = 0
    var defaultTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.layer.cornerRadius = 30
        timer.invalidate()
        
        if let breakTime = defaultTime {
            countDownLabel?.text = breakTime.count < 2 ? "00:0\(breakTime):00" : "00:\(breakTime):00"
            self.secondsPassed = Int(breakTime)!
        }
    }
    
    @objc func updateTimer() {
        if self.secondsPassed != 0 {
            print(secondsPassed)
            countDownLabel?.text = self.secondsPassed < 10 ? "00:0\(self.secondsPassed):00" : "00:\(self.secondsPassed):00"
            self.secondsPassed -= 1
        } else {
            countDownLabel.text = "00:00:00"
            timer.invalidate()
        }
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startBtnClicked(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
}

