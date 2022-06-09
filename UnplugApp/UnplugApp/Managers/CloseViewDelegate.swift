//
//  CloseViewDelegate.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/06/02.
//

import Foundation
import UIKit

protocol CloseViewDelegate: AnyObject {
    
    func didSelectClose(_ viewController: UIViewController)
}
