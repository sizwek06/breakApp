//
//  Constants.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/30.
//

import Foundation
import UIKit

struct Constants {
    
    static var showBreakItemSegue = "showBreakItem"
    
    static var addBreakItemSegue: String {
        "addBreakItem"
    }
    
    static var editButtonSegue: String {
        "editButtonSegue"
    }

    static func startButtonTitle(buttonCurrenTitle: String) -> String {
        return buttonCurrenTitle == "START" ? "STOP" : "START"
    }
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.clear
    static let outlineStrokeColor = Constants.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = Constants.rgb(r: 56, g: 25, b: 49)
    static let buttonOrange = Constants.rgb(r: 253, g: 58, b: 255)
}
