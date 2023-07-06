//
//  AddItemViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//

import UIKit

class AddItemViewController: UIViewController {
    
    enum Result {
        case save(String), cancell
    }

    @IBOutlet weak var itemTextField: UITextField!
    
    var selectedItem: Item?
    
    private var result: Result?
    
    var onViewDidDisapper: (Result) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = selectedItem?.name
    }
    
    @IBAction func saveItem(_ semder: Any){
        result = .save(itemTextField.text ?? "")
        guard let result = result else { return }
        onViewDidDisapper(result)
    }
    
}
