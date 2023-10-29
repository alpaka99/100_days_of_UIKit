//
//  Whistle.swift
//  UIKit_day_91
//
//  Created by user on 2023/10/27.
//

import CloudKit
import UIKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
