//
//  Coder.swift
//  UIKit_day_74
//
//  Created by user on 2023/08/29.
//

import Foundation

class Coder {
    var notes: [Note] = [Note]()
    let userDefaults = UserDefaults()
    
    func encode() {
//        guard let url = Bundle.main.url(forResource: "Notes", withExtension: "json") else { return }
        
//        let pathWithFileName = getDocumentDirectory().appendingPathComponent("Notes.json")
//
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let data = try? encoder.encode(notes) {
            do {
//                    try jsonData.write(to: pathWithFileName, atomically: true, encoding: .utf8)
                userDefaults.setValue(data, forKey: "Notes")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func decode() {
//        guard let url = Bundle.main.url(forResource: "Notes", withExtension: "json") else { return }
        
        
        let decoder = JSONDecoder()
        
        if let data = userDefaults.data(forKey: "Notes") {
            print("load from user defaults \(data)")
            if let notes = try? decoder.decode([Note].self, from: data) {
                self.notes = notes
            }
        } else {
            print("Cannot load from userdefaults")
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
