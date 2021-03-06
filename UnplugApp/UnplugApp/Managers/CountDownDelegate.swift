//
//  CountDownDelegate.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/22.
//

import Foundation

protocol CountDownBeganDelegate: AnyObject {
    func countDownStarted(count: String, timer: Timer)
    
    func resetTimeValue()
    
    func reloadTable()
}
