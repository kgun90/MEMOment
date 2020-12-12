//
//  MemoListCell.swift
//  MEMOment
//
//  Created by Geon Kang on 2020/12/04.
//  Copyright © 2020 Geon Kang. All rights reserved.
//

import UIKit

class MemoListCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
