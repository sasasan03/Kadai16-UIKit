//
//  ViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ItemTableView: UITableView!
    
    let cellIdentifier =
    
    var itemArray = [
    Item(name: "朝もく", isChecked: false),
    Item(name: "昼もく", isChecked: true),
    Item(name: "夜もく", isChecked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

