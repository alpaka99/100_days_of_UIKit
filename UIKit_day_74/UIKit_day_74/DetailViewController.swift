//
//  DetailViewController.swift
//  UIKit_day_74
//
//  Created by user on 2023/08/28.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    var number: Int!
    var coder: Coder!
    var note: Note!
    var delegate: UpdateDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save)),
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trash))
        ]
        
        navigationItem.backAction = UIAction(title: "Back") { [weak self] value in
            self?.save()
            self?.navigationController?.popViewController(animated: true)
        }
        
        
        textView.text = coder.notes[number].content
    }
    
    @objc func save() {
        coder.notes[number].content = textView.text
        coder.encode()
        
        self.delegate?.reload(index: IndexPath(row: number, section: 0))
    }
    
    @objc func trash() {
        print("Trash")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol UpdateDelegate {
    func reload(index: IndexPath)
}
