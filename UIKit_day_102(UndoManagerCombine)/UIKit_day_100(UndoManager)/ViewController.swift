//
//  ViewController.swift
//  UIKit_day_100(UndoManager)
//
//  Created by user on 11/9/23.
//

import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate {
    let notificationName: Notification.Name = Notification.Name("textfieldUndomanager")
    var text: String = ""
    var cancellableBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "UndoManager"
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "Undo", image: UIImage(named: "arrow.uturn.backward.circle"), target: self, action: #selector(undoTextField))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Redo", image: UIImage(named: "arrow.uturn.forward.circle"), target: self, action: #selector(redoTextField))
        
        self.view.backgroundColor = .white
        
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.publisher
            .sink { text in
              print(text)
            }
            .store(in: &cancellableBag)
        
        
        self.view.addSubview(textField)
    
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    @objc func undoTextField() {
        
    }
    
    @objc func redoTextField() {
        
    }
}


#Preview {
    ViewController()
}

extension UITextField {
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
