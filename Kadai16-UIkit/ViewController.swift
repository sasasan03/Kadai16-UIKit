//
//  ViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ItemTableView: UITableView!
    
    @IBAction func exitFromAddSave(segue: UIStoryboardSegue) { }
    
    @IBAction func exitFromAddCancel(segue: UIStoryboardSegue) { }
    
    let cellIdentifier = "cellIdentifier"
    
    private var itemName = ""
    private var itemNum = 0
    
    var editIndexPath: IndexPath?
    
    var itemArray = [
    Item(name: "朝もく", isChecked: false),
    Item(name: "昼もく", isChecked: true),
    Item(name: "夜もく", isChecked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemTableView.dataSource = self
        ItemTableView.delegate = self
        ItemTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let add = (segue.destination as? UINavigationController)?.topViewController as? AddItemViewController {
        //    print(">>>prepare", segue.identifier ?? "")
            switch segue.identifier ?? "" {
            case "addSegue":
                add.mode = AddItemViewController.Mode.add
                break
            case "editSegue":
                add.mode = AddItemViewController.Mode.edit(.init(name: itemName, index: itemNum))
                //🍔senderの中に入っているもののマーク
                if let indexPath = sender as? IndexPath {
                    let item = self.itemArray[indexPath.row]
                    add.name = item.name
                }
                break
            default :
                break
            }
        }
    }
}

//MARK: - TabelViewDelegateとDataSourceプロトコルに適合

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: itemArray配列の中に入っている個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK: cellを構築
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        cell.configure(item: itemArray[indexPath.row])
        return cell
    }
    //MARK: タップされたcellを識別
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isChecked.toggle()
        tableView.reloadData()
    }
    
    //MARK: タップされたcellの番号を取得し、segueに情報を渡す。
    //🍔
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        itemName = itemArray[indexPath.row].name
        print(">>>", itemName)
        itemNum = indexPath.row
//        editIndexPath = indexPath
//        print("+++", editIndexPath)
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
}
//MARK: - 自作したTextFieldDelegateに適合させる
extension ViewController: TextFieldDelegate {
    //MARK: 新しい要素を配列に入れる
    func didSaveAdd(neme: String) {
        self.itemArray.append(Item(name: neme, isChecked: false))
        ItemTableView.reloadData()
    }
    //MARK: 選択されたcellの配列を上書きする
    func didSaveEdit(name: String, index: Int) {
        guard let editIndexPath = editIndexPath else { return }
        itemArray[index].name = name
        ItemTableView.reloadRows(at: [editIndexPath] , with: .automatic)
    }
    
    
}

