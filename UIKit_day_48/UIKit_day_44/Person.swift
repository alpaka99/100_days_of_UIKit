//
//  Person.swift
//  UIKit_day_44
//
//  Created by user on 2023/05/25.
//

import UIKit

class Person: NSObject, NSCoding {
    var image: String
    var name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
}
