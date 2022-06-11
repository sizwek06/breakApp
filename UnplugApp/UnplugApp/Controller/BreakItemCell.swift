//
//  breakViewCellTableViewCell.swift
//  UnplugApp
//
//  Created by Sizwe Khathi on 2022/05/19.
//

import UIKit

class BreakItemCell: UITableViewCell {

    @IBOutlet weak var cellView: BreakItemCell!
    @IBOutlet weak var breakNameLabel: UILabel!
    @IBOutlet weak var breakDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with currentIndex: IndexPath) {
        breakDurationLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        cellView!.layer.borderWidth = 2
        cellView!.layer.borderColor = UIColor.black.cgColor
    }
}

//MARK: - UI Nib Details
extension BreakItem {
    
    static var nib: UINib {
        return UINib(nibName: cellItemIdKey, bundle: nil)
    }
//
//    static var identifier: String {
//        return String(describing: self)
//    }

    static var cellItemIdKey: String {
        return String(describing: self)
    }
}

