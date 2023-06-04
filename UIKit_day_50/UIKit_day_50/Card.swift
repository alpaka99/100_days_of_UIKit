//
//  Card.swift
//  UIKit_day_50
//
//  Created by user on 2023/06/04.
//

import UIKit

class Card: NSObject, Codable {
    let image: String
    let caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
