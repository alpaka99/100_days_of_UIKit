//
//  ViewController.swift
//  UIKit_day_58
//
//  Created by user on 2023/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var flag3: UIButton!
    @IBOutlet var flag2: UIButton!
    @IBOutlet var flag1: UIButton!
    
    var score = 0
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var answerNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setFlag()
        
        
    }

    func setFlag(_: UIAlertAction? = nil) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            self.flag1.transform = .identity
            self.flag2.transform = .identity
            self.flag3.transform = .identity
        })
        
        
        countries.shuffle()
        
        answerNumber = Int.random(in: 0...2)
        
        title = "Guess the flag for \(countries[answerNumber].uppercased()), score: \(score)"
        
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag1.layer.borderColor = UIColor.black.cgColor
        flag1.layer.borderWidth = 1
        
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag2.layer.borderColor = UIColor.black.cgColor
        flag2.layer.borderWidth = 1
        
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
        flag3.layer.borderColor = UIColor.black.cgColor
        flag3.layer.borderWidth = 1
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            switch sender.tag {
            case 0:
                self.flag1.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                break
            case 1:
                self.flag2.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                break
            case 2:
                self.flag3.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                break
            default:
                break
            }
        })
        
        if sender.tag == answerNumber {
            score += 1
            setFlag()
        } else {
            let ac = UIAlertController(title: "Wrong answer", message: "This flag is for \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: setFlag))

            present(ac, animated: true)
        }
    }
    

}

