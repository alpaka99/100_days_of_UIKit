//
//  ViewController.swift
//  UIKit_day_30
//
//  Created by user on 2023/04/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var flag3: UIButton!
    @IBOutlet var flag2: UIButton!
    @IBOutlet var flag1: UIButton!
    
    
    var countries = ["Estonia",
                     "France",
                     "Germany",
                     "Ireland",
                     "Italy",
                     "Monaco",
                     "Nigeria",
                     "Poland",
                     "Russia",
                     "Spain",
                     "UK",
                     "US”"].map { $0.lowercased() }
    var answerNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        flag1.layer.borderColor = UIColor.gray.cgColor
        flag2.layer.borderColor = UIColor.gray.cgColor
        flag3.layer.borderColor = UIColor.gray.cgColor
        
        flag1.layer.borderWidth = 1
        flag2.layer.borderWidth = 1
        flag3.layer.borderWidth = 1
        
        startGame()
    }
    
    func startGame() {
        countries.shuffle()
        answerNumber = Int.random(in: 0...2)
        
        title = "Choose the flag of \(countries[answerNumber])"
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    @IBAction func isRightFlag(_ sender: UIButton) {
        var title  = ""
        var message = ""
        
        title = sender.tag == answerNumber ? "You are correct :)" : "You are wrong :("
        
        message = "It's the flag of \(countries[answerNumber])"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        
        ac.addAction(cancel)
        present(ac, animated: true)
        
        startGame()
    }
}

