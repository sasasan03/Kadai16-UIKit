//
//  AddItemViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/07.
//

import UIKit

//viewControllerから渡されてきた値を表示して編集できるようにする。
//🟦デリゲートを使って値を渡す。
//🟥segueの役割

protocol TextFieldDelegate: AnyObject {
    //func didSaveAdd(neme: String)
    func didSaveEdit(name: String, index: Int)
}

class AddItemViewController: UIViewController {
    
    static let editSegueIdentifier = "editSegue"
    static let addSegueIdentifier = "addSegue"
    
    @IBOutlet weak var itemAddTextField: UITextField!

    //MARK: -Viewを構築するために必要なプロパティ
    var indexPath: IndexPath?
    var itemName: String?
    weak var delegate: TextFieldDelegate? = nil
    
    
    //MARK: - コンポーネント群
    
    //MARK: cancelボタンのセグエ
    @IBAction func pressCancelButton(_ sender: Any) { }
    
    //MARK: ここで値を渡しにいく（セーブ）
    @IBAction func pressSaveButton( _ sender: Any){
        guard let index = indexPath?.row else { return print("indexがnil")}
        print("🍔AddVC/Index", index)
        guard let text = itemAddTextField.text else {return print("textFieldがnil")}
        print("🍔AddVC/text", text)
        self.delegate?.didSaveEdit(name: text, index: index)
        self.dismiss(animated: true)
    }
    //MARK: VCから渡されてきた値を表示する
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemAddTextField.text = itemName ?? "nilだ"
    }
}


//var editText: ((String) -> Void)? = nil
