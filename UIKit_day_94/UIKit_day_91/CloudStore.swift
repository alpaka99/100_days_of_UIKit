//
//  CloudStore.swift
//  UIKit_day_91
//
//  Created by user on 2023/10/27.
//

import CloudKit
import Foundation

class CloudStore {
    static var store: CloudStore = CloudStore()
    let container = CKContainer(identifier: "iCloud.UIKit-day-91")

    init() {

    }
}
