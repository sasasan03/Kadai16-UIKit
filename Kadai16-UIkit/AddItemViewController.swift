//
//  AddItemViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/07.
//

import UIKit

protocol TextFieldDelegate: AnyObject {
    func didSaveAdd(neme: String)
    func didSaveEdit(name: String, index: Int)
}

class AddItemViewController: UIViewController {
    //Modeの切り替えで新規追加の画面なのか、編集する画面なのか決定している
    enum Mode {
        case add, edit(EditMode)
    }
    
    struct EditMode {
        let name: String
        let index: Int
    }

    var mode: Mode?
    
    weak var delegate: TextFieldDelegate?
    
    @IBOutlet weak var itemAddTextField: UITextField!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch mode {
        case .add:
            break
        case .edit(let editMode):
            itemAddTextField.text = editMode.name
        default:
            break
        }
    }

    @IBAction func pressSaveButton(sender: Any){
        guard let itemAddTextfield  = itemAddTextField else { return }
        switch mode {
        case .add:
            delegate?.didSaveAdd(neme: itemAddTextfield.text ?? "")
        case .edit(let editMode):
            delegate?.didSaveEdit(name: itemAddTextfield.text ?? "", index: editMode.index)
        default:
            return
            
        }
    }
    
    @IBAction func pressCancelButton(_ sender: Any) { }
}
