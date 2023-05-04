//
//  DetailViewController.swift
//  UIKit_day_40
//
//  Created by user on 2023/05/04.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImage()
    }
    
    func loadImage() {
        if let image = selectedImage {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(named: image)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
