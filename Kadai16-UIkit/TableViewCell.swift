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
    @IBOutlet weak var toEditViewButton: UIButton!
    
    
    func configure(item: Item){
        cellText.text = item.name
        checkIamge.image = UIImage(systemName: item.isChecked ? "flag.checkered.circle.fill" : "flag.checkered.circle")
    }
}
