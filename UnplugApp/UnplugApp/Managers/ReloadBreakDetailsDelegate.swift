//
//  ReloadDelegate.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/06/09.
//

import Foundation
import UIKit

protocol ReloadBreakDetailsDelegate: AnyObject {
    
    func refreshTitle(_ viewTitle: String)
    
    func refreshBreakDuration(_ breakDuration: Int)
}
