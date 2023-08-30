//
//  Note.swift
//  UIKit_day_74
//
//  Created by user on 2023/08/29.
//

import Foundation

struct Note: Codable {
    var content: String
}

struct Notes: Codable {
    var notes: [Note]
}
