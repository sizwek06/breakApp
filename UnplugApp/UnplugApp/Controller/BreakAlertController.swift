//
//  DeleteBreakController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/21.
//

import Foundation
import UIKit

class BreakAlertController: UIAlertController  {
    //TODO: Refactor class name to include AlertController
    
    var breakName: String
    var condition: BreakAlertConditions
    
    var closeViewDelegate: CloseViewDelegate?
    var countDownDelegate: CountDownBeganDelegate?
    
    enum BreakAlertConditions {
        case unknown
        case added
        case edit
        case complete
    }
    
    init(with breakName: String, andCondition condition: BreakAlertConditions = .unknown) {
        self.breakName = breakName
        self.condition = condition
        super.init(nibName: nil,  bundle: nil)
        //TODO: Gugs: Add the delegates over here as initializers (see breakName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDeleteAlertWithCurrentArrayIndex(_ currentArrayIndex: Int) -> UIAlertController {
        let deleteAlert = UIAlertController(title: "Delete \(breakName)?", message: "Are you sure you'd like to delete \(breakName)?", preferredStyle: .alert)
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAlertAction) in
            deleteAlert.dismiss(animated: true, completion: nil)
        }
        
        let deleteAlertAction = UIAlertAction(title: "Delete", style: .destructive) { (deleteAlertAction) in
            deleteAlert.dismiss(animated: true) {
                breaksArray.remove(at: currentArrayIndex)
                print("Should reloadTable soon")
                self.countDownDelegate?.reloadTable()
                self.closeViewDelegate?.didSelectClose(self)
            }
        }
        
        deleteAlert.addAction(cancelAlertAction)
        deleteAlert.addAction(deleteAlertAction)
        return deleteAlert
    }
    
    func showBreakAddedAlert() -> UIAlertController {
        var message: String?
        var title: String?
        
        switch condition {
        case .unknown:
            title = "Missing Information"
            message = "Please enter a break name in the text field!"
        case .added:
            title = "Break Successful"
            message = "Your new Break \(breakName) was added successfully!"
        case .edit:
            title = "Break Successful"
            message = "Your Break was updated successfully to \(breakName)!"
        case .complete:
            title = "Break Complete"
            message = "Your Break is over!"
        }
        
        let infoAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let oKAlertAction = UIAlertAction(title: "OK", style: .default) { (oKAlertAction) in
            infoAlert.dismiss(animated: true, completion: nil)
            self.closeViewDelegate?.didSelectClose(self)
        }
        
        infoAlert.addAction(oKAlertAction)
        return infoAlert
    }
}
