//
//  ViewController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/18.
//

import UIKit

class BreakItemVC: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    var defaultTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

