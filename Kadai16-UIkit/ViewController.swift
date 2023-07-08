//
//  ViewController.swift
//  Kadai16-UIkit
//
//  Created by sako0602 on 2023/07/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ItemTableView: UITableView!
    
    let cellIdentifier = "cellIdentifier"
    
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
            switch segue.identifier {
            case "addSegue":
                add.mode = AddItemViewController.Mode.Add
                break
            case "editSegue":
                add.mode = AddItemViewController.Mode.Edit
                //🟥senderの中に入っているもののマーク
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
    
    @IBAction func exitFromAddSave(segue: UIStoryboardSegue) {
        
    }

    @IBAction func exitFromAddCancel(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func exitFromEditSave(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func exitFromEditCancel(segue: UIStoryboardSegue) {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        cell.configure(item: itemArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isChecked.toggle()
        tableView.reloadData()
    }
    //🟥
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        editIndexPath = indexPath
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
    
    
}

