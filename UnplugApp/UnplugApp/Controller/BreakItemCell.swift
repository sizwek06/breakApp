//
//  breakViewCellTableViewCell.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/19.
//

import UIKit

class BreakItemCell: UITableViewCell {

    @IBOutlet weak var cellView: BreakItemCell!
    @IBOutlet weak var breakDurationLabel: UILabel!
    @IBOutlet weak var breakNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
