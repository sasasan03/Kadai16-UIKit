//
//  ViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//
import UIKit

class ViewController: UIViewController {

    var itemArray = [
        Item(name: "朝もく", isChecked: false),
        Item(name: "昼もく", isChecked: true),
        Item(name: "夜もく", isChecked: false)
    ]
    
    @IBOutlet weak var ItemTableView: UITableView!
    
    //編集画面に遷移した時に、addViewで表示させたいItemの名前とそのItemのIndex番号を渡す。
    var selectedItemIndex: IndexPath?
    var selectedItemName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemTableView.dataSource = self
        ItemTableView.delegate = self
        ItemTableView.register(UINib(nibName: TableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TableViewCell.cellIdentifier)
    }
    //値をもらうための準備をする。セグエが実行されようとしていることをViewContorllerへ通知する。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return print("identifierがnil") }
        
        switch identifier {
        case AddItemViewController.editSegueIdentifier:
            guard let nav = segue.destination as? UINavigationController else { return }
            guard let addVC =  nav.topViewController as? AddItemViewController else { return }
            //このViewがdelegateで、値を渡されることを宣言する。通知先をViewController自身に設定する。
            addVC.delegate = self
            //MARK: AddItemViewControllerのtextFieldに値を渡ための処理を書く。
            addVC.mode = AddItemViewController.Mode.Edit
            addVC.indexPath = selectedItemIndex
            addVC.itemName = selectedItemName
            segue.destination.storyboard
        case AddItemViewController.addSegueIdentifier:
            guard let nav = segue.destination as? UINavigationController else { return }
            guard let addVC =  nav.topViewController as? AddItemViewController else { return }
            addVC.delegate = self
            addVC.mode = AddItemViewController.Mode.Add
            
        default:
            break
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as! TableViewCell
        cell.configure(item: itemArray[indexPath.row])
        return cell
    }
    //MARK: タップされたcellのtoggleを反転する。
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //MARK: タップされたcellの番号を取得し、segueに情報を渡す。
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    //MARK: このメソッド内に書かれた内容がperformSegueを通して渡される
        selectedItemName = itemArray[indexPath.row].name
        selectedItemIndex = indexPath
        performSegue(withIdentifier: AddItemViewController.editSegueIdentifier, sender: indexPath)
    }
}
//MARK: - 自作したTextFieldDelegateを適合させる
extension ViewController: TextFieldDelegate { //UI
    //MARK: ここで新しい要素を配列に入れる処理を書く
    func didSaveAdd(neme: String) {
        self.itemArray.append(Item(name: neme, isChecked: false))
        ItemTableView.reloadData()
    }
    //MARK: ここで選択されたcellの配列を上書きする処理を書く
    func didSaveEdit(name: String, index: Int) {
        guard let editIndexPath = selectedItemIndex else { return }
        itemArray[index].name = name
        ItemTableView.reloadRows(at: [editIndexPath] , with: .automatic)
    }
}

