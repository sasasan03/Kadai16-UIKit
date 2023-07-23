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
    
    //MARK: - 新規追加と編集の画面の切り替えを行う。
    enum Mode {
        case Add
        case Edit
    }
    //空になることはないと考えたため、初期値をMode.Addに設定
    var mode = Mode.Add

    //MARK: -Viewを構築するために必要なプロパティ
    var indexPath: IndexPath?
    var itemName: String?
    weak var delegate: TextFieldDelegate?
    
    
    //MARK: - コンポーネント群
    @IBOutlet weak var itemAddTextField: UITextField!
    //MARK: cancelボタンのセグエ
    @IBAction func pressCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ここで値を渡しにいく（セーブボタン）
    @IBAction func pressSaveButton( _ sender: Any){
        switch mode {
        case .Add:
            guard let text = itemAddTextField.text else { return print("🍔：AddMode/textFieldがnil")}
            delegate?.didSaveAdd(neme: text)
            self.dismiss(animated: true)
            return
        case .Edit:
            guard let index = indexPath?.row ,let text = itemAddTextField.text else {
                print("🍔: Invalid index or textField")
                return
            }
            self.delegate?.didSaveEdit(name: text, index: index)
            self.dismiss(animated: true)
            return
        }
    }
    //MARK: VCから渡されてきた値を表示する
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == Mode.Edit {
            self.itemAddTextField.text = itemName ?? "🍔：nilだ"
        }
    }
}
