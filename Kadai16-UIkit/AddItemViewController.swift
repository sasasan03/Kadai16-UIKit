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
    
    static let editSegueIdentifier = "editSegue"
    static let addSegueIdentifier = "addSegue"
    

    //MARK: -Viewを構築するために必要なプロパティ
    var indexPath: IndexPath?
    var itemName: String?
    weak var delegate: TextFieldDelegate? = nil
    
    
    //MARK: - コンポーネント群
    @IBOutlet weak var itemAddTextField: UITextField!
    //MARK: cancelボタンのセグエ
    @IBAction func pressCancelButton(_ sender: Any) { }
    
    //MARK: ここで値を渡しにいく（セーブボタン）
    @IBAction func pressSaveButton( _ sender: Any){
        guard let index = indexPath?.row else { return print("indexがnil")}
        guard let text = itemAddTextField.text else { return print("textFieldがnil")}
        self.delegate?.didSaveEdit(name: text, index: index)
        self.dismiss(animated: true)
    }
    //MARK: VCから渡されてきた値を表示する
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemAddTextField.text = itemName ?? "nilだ"
    }
}
