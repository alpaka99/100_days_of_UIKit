//
//  ViewController.swift
//  UIKit_day_52
//
//  Created by user on 2023/06/08.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var intensity: UISlider!
    @IBOutlet var imageView: UIImageView!
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Instafilter"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        currentImage = image
        imageView.image = currentImage
        dismiss(animated: true)
    }

    @IBAction func changeFilter(_ sender: Any) {
    }
    
    
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
    }
}

