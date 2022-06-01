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
    
    var countDownDelegate: CountDownBeganDelegate?
    
    var defaultTime: Int?
    var breakName: String?
    var breakLength = "5"
    var breakArrayIndex: Int?
    
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
    
    @IBAction func durationSegmentClicked(_ sender: UIControl) {
        switch minsSegmentOutlet.selectedSegmentIndex {
        case 0:
            breakLength = "5"
        case 1:
            breakLength = "10"
        case 2:
            breakLength = "15"
        case 3:
            breakLength = "30"
        case 4:
            breakLength = "60"
        default:
            breakLength = "5"
        }
    }
    
    @IBAction func topRightButtonClicked(_ sender: UIBarButtonItem) {
        if breakNameTextField.hasText == false {
            present(PopUpController().showBreakAddedAlert(nil, nil), animated: true)
        }
        else if let newbreakName = breakNameTextField.text {
            if navBarItemOutlet.rightBarButtonItem?.title == "Add" {
                breaksArray.append(BreakItem(name: newbreakName, breakLength: breakLength, colour: "black"))
                present(PopUpController().showBreakAddedAlert(newbreakName, "Add"), animated: true)
            }
            else if navBarItemOutlet.rightBarButtonItem?.title == "Edit" {
                if let arrayIndex = breakArrayIndex {
                    breaksArray[arrayIndex].name = newbreakName
                    breaksArray[arrayIndex].breakLength = breakLength
                    present(PopUpController().showBreakAddedAlert(newbreakName, "Edit"), animated: true)
                }
            }
        }
        countDownDelegate?.reloadTable()
    }
}

//MARK: - View Manipulation
extension AddBreakViewController {
    override func viewDidLayoutSubviews() {
        self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 3, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 3)
        self.view.layer.cornerRadius = 20
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
