//
//  Person.swift
//  UIKit_day_43
//
//  Created by user on 2023/05/18.
//

import UIKit

class Person: NSObject {
    var name: String
    let image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
