//
//  ViewController.swift
//  UIKit_day_29
//
//  Created by user on 2023/04/04.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadInitialdata()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(openAlertTextField))
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(restartGame))
    }
    
    func loadInitialdata() {
        let url = Bundle.main.url(forResource: "start", withExtension: "txt")
        let initString = try! String(contentsOf: url!)
        allWords = initString.components(separatedBy: "\n")
        title = allWords.randomElement()?.lowercased()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func restartGame() {
        title = allWords.randomElement()
        usedWords = [String]()
        tableView.reloadData()
    }
    
    @objc func openAlertTextField() {
        let ac = UIAlertController(title: "Enter word", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [ weak self, weak ac ] _  in
            guard  let answer = ac?.textFields?[0].text else { return }
            self?.submit(word: answer) // 해당 view controller 안에 있는 메서드를 불러오는것 -> 그렇기 때문에 weak 하게 reference 해야함.
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func submit(word: String) {
        if !(isOriginal(word: word) && isPossible(word: word) && isReal(word: word)) {
            let ac = UIAlertController(title: "Wrong scarambled word", message: "That word is not right", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            ac.addAction(cancel)
            present(ac, animated: true)
            return
        }
        
        usedWords.insert(word, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func isOriginal(word: String) -> Bool {
        if usedWords.contains(word) {
            return false
        }
        return true
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 || word == title {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    
}

