//
//  ViewController.swift
//  UIKit_day_84
//
//  Created by user on 2023/09/29.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    let password = "Open Sesame"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Nothing to see here"
        
        KeychainWrapper.standard.set(password, forKey: "Password")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func adjustKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }

    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Lock", image: UIImage(systemName: "lock"), target: self, action: #selector(saveSecretMessage))
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        title = "Nothing to see here"
    }
    
    
    @IBAction func authenticationTapped(_ sender: Any) {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        // error
                        let ac = UIAlertController(title: "Error!", message: "Face ID Failed", preferredStyle: .alert)
                        
                        ac.addTextField { (textField) in
                            textField.placeholder = "Enter Password"
                        }
                        
                        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            guard let input = ac.textFields?[0].text else { return }
                            guard let password = KeychainWrapper.standard.string(forKey: "Password") else { return }
                            
                            if input == password {
                                self?.unlockSecretMessage()
                            }
                            
                        })
                        
                        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            print("No biometry")
        }
    }
}


