//
//  ViewController.swift
//  UIKit_day_21
//
//  Created by user on 2023/03/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button3: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button1: UIButton!
    
    var countries = [String]()
    var answerNum = 0
    var score  = 0
    var rounds = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if rounds == 10 {
//            var roundAlertVC = UIAlertController(title: "Finished 10th round", message: "Your score is \(score)", preferredStyle: .alert)
//
//            var roundAlertButton = UIAlertAction(title: "Okay", style: .default, handler: resetGame)
//
//            roundAlertVC.addAction(roundAlertButton)
//
//            present(roundAlertVC, animated: true)
            print("Over")
        }
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        button2.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        button3.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        
        nxtRound()
        
        
    }

    func nxtRound(_ alert: UIAlertAction? = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        
        
        answerNum = Int.random(in: 0...2)
        
        title = "\(countries[answerNum].uppercased()). Score: \(score). Round: \(rounds)"
        
        rounds += 1
        
        
    }
    
    func resetGame(_ : UIAlertAction? = nil) {
        score = 0
        rounds = 0
    }
    
    
    @IBAction func flagTapped(_ sender: UIButton) {
        var alertMessage = ""
        
        if answerNum ==  sender.tag {
            alertMessage = "You are correct!"
            score += 1
        } else {
            alertMessage = "You are wrong :( That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        var alertVC = UIAlertController(title: alertMessage, message: "Your score is \(score)", preferredStyle: .alert)
        
        var alertButton = UIAlertAction(title: "Continue", style: .default, handler: nxtRound)
        
        alertVC.addAction(alertButton)
        
        present(alertVC, animated: true)
        
        
        
    }
    
}

