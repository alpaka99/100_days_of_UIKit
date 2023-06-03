//
//  Person.swift
//  UIKit_day_44
//
//  Created by user on 2023/05/25.
//

import UIKit

class Person: NSObject, Codable {
    var image: String
    var name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
