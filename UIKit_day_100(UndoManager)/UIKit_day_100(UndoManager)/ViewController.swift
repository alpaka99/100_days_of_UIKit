//
//  ViewController.swift
//  UIKit_day_100(UndoManager)
//
//  Created by user on 11/9/23.
//

import UIKit

class ViewController: UITableViewController {
    var items: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "UndoManager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRow))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(removeRow))
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    }
    
    @objc func addRow() {
        if items.count % 2 == 0 {
            items.add("🙂 upside")
        } else {
            items.add("🙃 downside")
        }
        undoManager?.registerUndo(withTarget: items) {
            $0.removeLastObject()
        }
        tableView.reloadData()
    }
    
    @objc func removeRow() {
        let popedItem = items[items.count-1]
        items.removeLastObject()
        tableView.reloadData()
        undoManager?.registerUndo(withTarget: items) {
            $0.add(popedItem)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row] as! String
        
        return cell
    }
}

