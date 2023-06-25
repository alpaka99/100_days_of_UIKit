//
//  DetailViewController.swift
//  UIKit_day_59
//
//  Created by user on 2023/06/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var en_short_name: UILabel!
    @IBOutlet var alpha_3_code: UILabel!
    @IBOutlet var alpha_2_code: UILabel!
    @IBOutlet var num_code: UILabel!
    
    var country: Country? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = country?.nationality
        
        num_code.text = country?.num_code
        alpha_2_code.text = country?.alpha_2_code
        alpha_3_code.text = country?.alpha_3_code
        en_short_name.text = country?.en_short_name
    }

}
