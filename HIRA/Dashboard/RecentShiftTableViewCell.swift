//
//  RecentShiftTableViewCell.swift
//  HIRA
//
//  Created by Debashis  on 28/12/17.
//  Copyright © 2017 Debashis . All rights reserved.
//

import UIKit

class RecentShiftTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var shiftDate: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!    
    @IBOutlet weak var route: UILabel!
    @IBOutlet weak var markerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
