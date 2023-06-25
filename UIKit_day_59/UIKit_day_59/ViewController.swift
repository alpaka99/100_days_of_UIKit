//
//  ViewController.swift
//  UIKit_day_59
//
//  Created by user on 2023/06/22.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Milestone: Projects 13~15"
        
        loadJSON()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1) \(countries[indexPath.row].nationality)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.country = countries[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadJSON() {
        
        let urlPath = Bundle.main.url(forResource: "countries", withExtension: "json")!
        
        let decoder = JSONDecoder()
        
        if let data  = try? Data(contentsOf: urlPath) {
            if let decodedData = try? decoder.decode([Country].self, from: data) {
                countries = decodedData
            } else {
                print("Cannot decode json")
            }
        } else {
            print("Cannot find json")
        }
        
    }
}

