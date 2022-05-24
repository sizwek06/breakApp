//
//  StopTimerDelegate.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/24.
//

import Foundation

protocol StopTimerDelegate: AnyObject {
    func clearOldCountDownStarted(_ timer: Timer)
}
