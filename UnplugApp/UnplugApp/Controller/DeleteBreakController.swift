//
//  DeleteBreakController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/21.
//

import Foundation
import UIKit

class DeleteBreakController: UIAlertController  {
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
}
