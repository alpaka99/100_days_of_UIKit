//
//  ViewController.swift
//  UIKit_day_32
//
//  Created by user on 2023/04/07.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Milestone 4-6"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addShoppingItem))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearShoppingList))
        
        navigationItem.rightBarButtonItems = [add, refresh]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem")
        cell?.textLabel?.text = shoppingList[indexPath.row]
        return cell!
    }
    
    
    @objc func addShoppingItem() {
        let ac = UIAlertController(title: "Add shopping item", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        
        let submit = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let item = ac.textFields?[0].text else { return }
            
            self?.shoppingList.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(submit)
        
        present(ac, animated: true)
        
    }
    
    
    @objc func clearShoppingList() {
        shoppingList = [String]()
        tableView.reloadData()
    }
    
    @objc func shareShoppingList() {
        let data = shoppingList.joined(separator: "\n")
        let items: [Any] = [data]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Delete alert", message: "Do you really want to delete this item?", preferredStyle: .alert)
        
        let deleteButton = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            let row = indexPath.row
            self?.shoppingList.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(deleteButton)
        ac.addAction(cancel)
        
        present(ac, animated: true)
        
    }
}

