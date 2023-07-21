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
    let indexPath: IndexPath? = nil
    var delegate: TextFieldDelegate? = nil
    
    
    //MARK: - コンポーネント
    
    //MARK: cancelボタンのセグエ
    @IBAction func pressCancelButton(_ sender: Any) { }
    
    //MARK: いる？
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    //MARK: ここで値を渡しにいく（セーブ）
    @IBAction func pressSaveButton( _ sender: Any){
        guard let index = indexPath?.row else { return print("indexがnil")}
        guard let text = itemAddTextField.text else {return print("textFieldがnil")}
        self.delegate?.didSaveEdit(name: text, index: index)
        self.dismiss(animated: true)
    }
    //MARK: VCから渡されてきた値を表示する
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


//var editText: ((String) -> Void)? = nil
