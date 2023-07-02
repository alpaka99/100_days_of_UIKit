//
//  ViewController.swift
//  UIKit_day_64
//
//  Created by user on 2023/07/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // print() debugging
        print("I'm insinde the viewDidLoad() method.")
        
        print("Some message", terminator: ".")
        
        print(1, 2, 3, 4, 5, separator: "-")
        
        
        
        assert(1 == 1, "Math fauilure!")
//        assert(1 == 2, "Math fauilure!")
        
        for i in 1...100 {
            print("Got number \(i)")
        }
    }


}

