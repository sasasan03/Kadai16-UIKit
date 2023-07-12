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
    var name = ""
    
    
    @IBOutlet weak var itemAddTextField: UITextField!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch mode {
        case .add:
            if segue.identifier == "addSegue" {
                let addView = segue.destination as! AddItemViewController
                addView.name = ""
            }
        case .edit(let editMode):
            if segue.identifier == "editSegue" {
                let editView = segue.destination as! AddItemViewController
                editView.name = itemAddTextField.text!
               
            }
        default:
            break
        }
    }
            

    @IBAction func pressSaveButton( _ sender: Any){
        guard let name = itemAddTextField.text else { return }
        let mainView = self.storyboard?.instantiateViewController(identifier: "mainVC") as! ViewController
        
        switch mode {
        case .add:
            mainView.sample = itemAddTextField.text!
            //mainView.itemArray.append(Item(name: itemAddTextField.text!, isChecked: false))
            self.navigationController?.pushViewController(mainView, animated: true)
        case .edit(let editMode):
            break
        default:
            break
        }
        
        
        
        
        //        guard let itemAddTextfield  = itemAddTextField.text else { return }
        //        print("itemAddTF", itemAddTextfield)
        //        switch mode {
        //        case .add:
        //            delegate?.didSaveAdd(neme: itemAddTextfield)
        //        case .edit(let editMode):
        //            delegate?.didSaveEdit(name: itemAddTextfield,index: editMode.index)
        //        default:
        //            return
        //        }
    }
    
    @IBAction func pressCancelButton(_ sender: Any) { }
}

