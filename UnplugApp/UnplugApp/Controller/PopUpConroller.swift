//
//  DeleteBreakController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/21.
//

import Foundation
import UIKit

class PopUpConroller: UIAlertController  {
    //TODO: Refactor class name to include AlertController
    
    var breakName: String?
    
    func showDeleteAlert(_ breakName: String) -> UIAlertController {
        let deleteAlert = UIAlertController(title: "Delete \(breakName)?", message: "Are you sure you'd like to delete \(breakName)?", preferredStyle: .alert)
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAlertAction) in
            deleteAlert.dismiss(animated: true, completion: nil)
        }
        
        let deleteAlertAction = UIAlertAction(title: "Delete", style: .destructive) { (cancelAlertAction) in
            deleteAlert.dismiss(animated: true, completion: nil)
            //TODO: Add delete break functionality
        }
        
        deleteAlert.addAction(cancelAlertAction)
        deleteAlert.addAction(deleteAlertAction)
        return deleteAlert
    }
    
    func showBreakAddedAlert(_ breakName: String?, _ condition: String?) -> UIAlertController {
        var message: String?
        var title: String?
        
        if condition == nil {
            title = "Missing Information"
            message = "Please enter a break name in the text field!"
        } else if condition == "Edit" {
            title = "Break Successful"
            message = "Your new Break \(breakName!) was updated successfully!"
        }  else if condition == "Add" {
            title = "Break Successful"
            message = "Your new Break \(breakName!) was added successfully!"
        }
        
        let infoAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let oKAlertAction = UIAlertAction(title: "OK", style: .default) { (oKAlertAction) in
            infoAlert.dismiss(animated: true, completion: nil)
        }
        
        infoAlert.addAction(oKAlertAction)
        return infoAlert
    }
}
