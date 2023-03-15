//
//  ViewController.swift
//  UIKit_day_18
//
//  Created by user on 2023/03/15.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath! // 이거 틀림
//        let items = try! fm.contentsOfDirectory(atPath: path)
//
//        for item in items {
//            if item.hasPrefix("nssl") {
//                pictures.append(item)
//            }
//        }
        
        print(pictures)
        
        title = "Storm Viewer"
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! // 이거 틀림
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let detailView = self.storyboard?.instantiateViewController(withIdentifier: "Detail") else {
//            return
//        }
        
//        self.present(detailView, animated: true)
//    }
}

