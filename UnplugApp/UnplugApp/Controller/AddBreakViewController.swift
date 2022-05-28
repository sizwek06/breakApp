//
//  AddBreakViewController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/22.
//

import UIKit

class AddBreakViewController: UIViewController {
    
    @IBOutlet weak var navBarItemOutlet: UINavigationItem!
    
    @IBOutlet weak var minsSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var breakNameTextField: UITextField!
    
    var defaultTime: Int?
    var breakName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breakNameTextField.delegate = self
        
        if let currentBreak = breakName {
            self.navigationItem.title = currentBreak
            breakNameTextField.text = currentBreak
            navBarItemOutlet.title = currentBreak
            navBarItemOutlet.rightBarButtonItem?.title = "Edit"
        } else {
            navBarItemOutlet.title = "New Break"
            navBarItemOutlet.rightBarButtonItem?.title = "Add"
        }
        NotificationCenter.default.addObserver(self, selector: #selector(AddBreakViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

//MARK: - View Manipulation
extension AddBreakViewController {
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 5 * 2, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 3)
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.view.frame.origin.y)
            if self.view.frame.origin.y != 0 {
                print(keyboardSize.height)
                self.view.frame.origin.y -= keyboardSize.height
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 3)
                self.view.layoutSubviews()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - TextField Delegate
extension AddBreakViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y = 0
        self.view.endEditing(true)
        return false
    }
}
