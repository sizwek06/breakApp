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
    var minsPassed = 0
    var secsPassed = 0
    var defaultTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.layer.cornerRadius = 30
        
        if let breakTime = defaultTime {
            countDownLabel?.text = breakTime.count < 2 ? "00:0\(breakTime):00" : "00:\(breakTime):00"
            self.minsPassed = Int(breakTime)!
        }
    }
    
    @objc func updateTimer() {
        if self.secsPassed != self.minsPassed * 10 {
            self.secsPassed += 1
            let currentTime = timeConversion(self.secsPassed)
            countDownLabel?.text = String(format: "%02d:%02d:%02d", 0, currentTime[0], currentTime[1])
        } else {
            timer.invalidate()
        }
    }
    
    func timeConversion(_ seconds: Int) -> [Int] {
        return [seconds / 60, seconds % 60]
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @IBAction func startBtnClicked(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //MARK: - Testing Via Seconds
//    if self.secondsPassed != 0 {
//        print(secondsPassed)
//        let (h, m, s) = timeConversion(secondsPassed)
//        print((h,m,s))
//        countDownLabel?.text = self.secondsPassed < 10 ? "0\(h):0\(m):\(s)" : "\(h):\(m):\(s)"
//        self.secondsPassed -= 1
//    } else {
//        countDownLabel.text = "00:00:00"
//        timer.invalidate()
//    }
//
}

