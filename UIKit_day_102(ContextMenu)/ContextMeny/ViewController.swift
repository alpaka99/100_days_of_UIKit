//
//  ViewController.swift
//  ContextMeny
//
//  Created by user on 11/15/23.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "hi\(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView,
                            contextMenuConfigurationForRowAt indexPath: IndexPath,
                            point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: {
                suggestedActions in
            let continueTalkAction = UIAction(
                title: NSLocalizedString(
                    "이 문구로 이어서 대화 시작",
                    comment: ""
                ),
                image: UIImage(named: "current.start")
            ) { action in
                print("from: \(indexPath.row)")
            }
            
            let startTalkAction = UIAction(
                title: NSLocalizedString(
                    "이 문구로 새 대화 시작",
                    comment: ""
                ),
                image: UIImage(named: "new.start")
            ) { action in
                print("from: \(indexPath.row)")
            }
            
            let copyAction = UIAction(
                title: NSLocalizedString(
                    "복사",
                    comment: ""
                ),
                image: UIImage(named: "copy")
            ) { action in
                print("from: \(indexPath.row)")
            }
            
            let addToShortcutAction = UIAction(
                title: "텍스트 대치에 추가",
                image: UIImage(named: "add.textreplace")
            ) { action in
                print("from: \(indexPath.row)")
            }
            
            
            
            return UIMenu(title: "TALKLAT ContextMenu", children: [continueTalkAction, startTalkAction, copyAction, addToShortcutAction])
        })
    }

}

