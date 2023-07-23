//
//  ViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//
import UIKit

class ViewController: UIViewController {
    
    static let StoryBoardID = "mainVC"

    @IBOutlet weak var ItemTableView: UITableView!
    
    var selectedItemIndex: IndexPath?
    var selectedItemName: String?
    
    var itemArray = [
    Item(name: "朝もく", isChecked: false),
    Item(name: "昼もく", isChecked: true),
    Item(name: "夜もく", isChecked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemTableView.dataSource = self
        ItemTableView.delegate = self
        ItemTableView.register(UINib(nibName: TableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TableViewCell.cellIdentifier)
    }
    //値をもらうための準備をする。セグエが実行されようとしていることをViewContorllerへ通知する。値の渡し方prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return print("identifierがnil") }
        
        switch identifier {
        case AddItemViewController.editSegueIdentifier:
            if let addVC = segue.destination as? AddItemViewController {
                //このViewがdelegateで、値を渡されることを明示する。
                addVC.delegate = self
                //MARK: AddItemViewControllerのtextFieldに値を渡す。
                addVC.indexPath = selectedItemIndex
                addVC.itemName = selectedItemName
            }
            
        case AddItemViewController.addSegueIdentifier:
            if let addVC = segue.destination as? AddItemViewController {
                addVC.delegate = self
            }
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
    //MARK: タップされたcellとtoggleを反転する。
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
extension ViewController: TextFieldDelegate {
    //MARK: 新しい要素を配列に入れる
    func didSaveAdd(neme: String) {
        self.itemArray.append(Item(name: neme, isChecked: false))
        ItemTableView.reloadData()
    }
    //MARK: 選択されたcellの配列を上書きする
    func didSaveEdit(name: String, index: Int) {
        guard let editIndexPath = selectedItemIndex else { return }
        itemArray[index].name = name
        ItemTableView.reloadRows(at: [editIndexPath] , with: .automatic)
    }
}

