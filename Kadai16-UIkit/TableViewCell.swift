//
//  TableViewCell.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellText: UILabel!
    @IBOutlet weak var checkIamge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
