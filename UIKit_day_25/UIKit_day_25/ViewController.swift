//
//  ViewController.swift
//  UIKit_day_25
//
//  Created by user on 2023/03/24.
//

import UIKit
import WebKit

class ViewController: UITableViewController {
    var websites = ["apple", "naver", "google", "hackingwithswift", "github"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website")
        
        cell?.textLabel?.text = websites[indexPath.row]
        cell?.imageView?.image = UIImage(named: websites[indexPath.row])
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {
            print("Cannot instantiate DetailViewController")
            return
        }
        
        vc.website = websites[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }


}

