//
//  ViewController.swift
//  UIKit_day_39
//
//  Created by user on 2023/05/02.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        DispatchQueue.global(qos: .userInteractive).async {
            [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
    
//            if let url = URL(string: urlString) {
//                if let data = try? Data(contentsOf: url) {
//                    self.parse(json: data)
//                }
//            }
    }

    

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                [weak self] in
                self?.tableView.reloadData()
                return
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check your connection and try again.", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default))

            self?.present(ac, animated: true)
            
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Petition", for: indexPath)
        
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: self?.petitions[indexPath.row].title, message: self?.petitions[indexPath.row].body, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            self?.present(ac, animated: true)
            
            return
            
        }
    }
}

