//
//  ViewController.swift
//  UIKit_day23
//
//  Created by user on 2023/03/21.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        title = "Share the flag"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row]
        
        var cellImage = UIImage(named: countries[indexPath.row])
//        cellImage.borderWidth = 1
        cell.imageView?.image = cellImage
//        cell.layer.borderWidth = 1
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {
            print("Cannot create instantiate view controller for DetailView")
            return
        }
        
        vc.country = countries[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }


}

