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
    let textField = UITextField()
    var text: String = ""
    var cancellableBag = Set<AnyCancellable>()
    var textRecord: NSMutableArray = NSMutableArray()
    var editingText: String = ""
    var textUndoManager: UndoManager = UndoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "UndoManager"
        
        // undo bar button
        let undoButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: 44,
            height: 44
        ))
        undoButton.setImage(
            UIImage(systemName: "arrow.uturn.left.circle"),
            for: .normal
        )
        undoButton.addTarget(
            self,
            action: #selector(undoTextField),
            for: .touchDown
        )
        let undoLabel = UILabel(frame: CGRect(
            x: 0,
            y: 20,
            width: 44,
            height: 30
        ))
        undoLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        undoLabel.text = "Undo"
        undoLabel.textColor = .black
        undoLabel.backgroundColor = .clear
        undoLabel.textAlignment = .center
        undoButton.addSubview(undoLabel)
        
        // redo bar button
        let redoButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: 44,
            height: 44
        ))
        redoButton.setImage(
            UIImage(systemName: "arrow.uturn.right.circle"),
            for: .normal
        )
        redoButton.addTarget(
            self,
            action: #selector(redoTextField),
            for: .touchDown
        )
        let redoLabel = UILabel(frame: CGRect(
            x: 0,
            y: 20,
            width: 50,
            height: 30
        ))
        redoLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        redoLabel.text = "Redo"
        redoLabel.textColor = .black
        redoLabel.backgroundColor = .clear
        redoLabel.textAlignment = .center
        redoButton.addSubview(redoLabel)
        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "arrow.uturn.left.circle"),
//            style: .plain,
//            target: self,
//            action: #selector(undoTextField)
//        )
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(
//                systemName: "arrow.uturn.right.circle"),
//            style: .plain,
//            target: self,
//            action: #selector(redoTextField)
//        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: undoButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: redoButton)
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.view.backgroundColor = .white
        
        
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.publisher
            .sink { [weak self] text in
                print(text)
                self?.registerUndo(text: self?.editingText ?? "")
                self?.editingText = self?.textField.text ?? ""
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
    
    func registerUndo(text: String) {
        print("Registering undo")
        if textUndoManager.isUndoRegistrationEnabled {
            textUndoManager.registerUndo(withTarget: self) { [weak self] _ in
                if let currentText = self?.textField.text {
                    self?.registerUndo(text: currentText)
                }
                self?.textField.text = text
            }
            buttonDisableControl()
        }
    }
    
    @objc func undoTextField() {
        if textUndoManager.canUndo {
            textUndoManager.undo()
            editingText = textField.text!
        }
        buttonDisableControl()
    }
    
    @objc func redoTextField() {
        if textUndoManager.canRedo {
            textUndoManager.redo()
            editingText = textField.text!
        }
        
        buttonDisableControl()
    }
    
    func buttonDisableControl() {
        // undo disable enable control
        if self.textUndoManager.canUndo {
            navigationItem.leftBarButtonItem?.isEnabled = true
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = false
        }
        
        if self.textUndoManager.canRedo {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
}


//#Preview {
//    ViewController()
//}

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
