//
//  ViewController.swift
//  UIKit_day_54
//
//  Created by user on 2023/06/12.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var intensity: UISlider!
    @IBOutlet var imageView: UIImageView!
    
    var beginImage: UIImage!
    var context: CIContext!
    var currentImage: UIImage!
    var currentFilter: CIFilter!
    var filterName: String = "CISepiaTone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "InstaFilter"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    @objc func addPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }


    @IBAction func changeFilter(_ sender: Any) {
        guard imageView.image != nil else {
            let ac = UIAlertController(title: "No image on the image view", message: "Please select image before choosing a filter", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
            
            return
        }
        
        
        let ac = UIAlertController(title: filterName, message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        
        guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: actionTitle)
        filterName = actionTitle
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
                // we got back an error!
                let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
    }
    
    @IBAction func intensityChanged(_ sender: UISlider) {
        applyProcessing()
    }
}

