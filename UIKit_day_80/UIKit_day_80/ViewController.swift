//
//  ViewController.swift
//  UIKit_day_80
//
//  Created by user on 2023/09/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType = (currentDrawType + 1) % 5
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // awsome drawing code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addRect(rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
}

