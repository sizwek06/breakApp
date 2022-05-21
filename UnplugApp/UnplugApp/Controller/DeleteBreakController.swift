//
//  DeleteBreakController.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/21.
//

import Foundation
import UIKit

class DeleteBreakController: UIAlertController  {
    
    func showDeleteAlert() -> UIAlertController {
        let deleteAlert = UIAlertController(title: "Delete the break?", message: "Are you sure you'd like to Delete the break?", preferredStyle: .alert)
        
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
