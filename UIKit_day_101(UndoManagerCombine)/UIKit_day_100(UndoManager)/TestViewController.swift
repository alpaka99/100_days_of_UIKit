//
//  TestViewController.swift
//  UIKit_day_100(UndoManager)
//
//  Created by user on 11/14/23.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let textField = UITextField()
        textField.backgroundColor = .red
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 200),
        ])
        
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


#Preview {
    TestViewController()
}
