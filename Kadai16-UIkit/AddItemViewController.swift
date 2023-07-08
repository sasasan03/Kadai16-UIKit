//
//  AddItemViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/07.
//

import UIKit

class AddItemViewController: UIViewController {
    
    enum Mode {
        case Add, Edit
    }

    var mode = Mode.Add
    
    @IBOutlet weak var itemAddTextField: UITextField!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == .Edit {
            itemAddTextField.text = name
        }
    }

    @IBAction func pressSaveButton(sender: AnyObject){
        let identifier = (mode == .Add) ? "exitFromAddBySaveSegue" : ""
    }
    
}
