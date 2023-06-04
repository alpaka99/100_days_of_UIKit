//
//  ViewController.swift
//  UIKit_day_50
//
//  Created by user on 2023/06/04.
//

import UIKit

class ViewController: UITableViewController, UINavigationControllerDelegate ,UIImagePickerControllerDelegate {

    var cards: [Card] = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
        
        load()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = cards[indexPath.row].caption
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        
    }
    
    @objc func addPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let ac = UIAlertController(title: "Please", message: "Enter caption for this image", preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac, weak picker] _ in
            let caption = ac?.textFields?[0].text
            
            let card = Card(image: imageName, caption: caption ?? "Unknown")
            self?.cards.append(card)
            self?.save()
            self?.tableView.reloadData()
            
            ac?.dismiss(animated: true)
            picker?.dismiss(animated: true)
        })
        
        
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(cards) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "Cards")
        } else {
            print("Failed to save cards")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        if let savedCards = defaults.object(forKey: "Cards") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                cards = try jsonDecoder.decode([Card].self, from: savedCards)
            } catch {
                print("Failed to load cards")
            }
        }
        
        tableView.reloadData()
    }

}

