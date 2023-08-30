//
//  ViewController.swift
//  UIKit_day_74
//
//  Created by user on 2023/08/28.
//

import UIKit

class ViewController: UITableViewController, UpdateDelegate {
    
    var coder = Coder()
    var notes: [Note] = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "UIKit day 74"
        
        coder.decode()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coder.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = coder.notes[indexPath.row].content
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailView") as! DetailViewController
        vc.number = indexPath.row
        vc.coder = coder
        vc.delegate = self // 이걸 안해서 update 가 안됨. 아직 delegate 패턴에 대한 이해가 많이 부족한듯
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func addNote() {
        coder.notes.append(Note(content: "Temporary Memo"))
        self.tableView.reloadData()
        coder.encode()
    }
    
    func reload(index: IndexPath) {
        self.tableView.reloadRows(at: [index], with: .automatic)
    }
}

