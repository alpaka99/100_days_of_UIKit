//
//  ViewController.swift
//  UIKit_day_89
//
//  Created by user on 2023/10/13.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addressBar: UITextField!
    
    weak var activeWebView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBrowser))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBrowser))
        
        navigationItem.rightBarButtonItems = [delete, add]
        
        addressBar.delegate = self
    }
    
    func setDefaultTitle() {
        title = "Multi Browser"
    }

    @objc private func addBrowser() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        stackView.addArrangedSubview(webView)
        
        let url = URL(string: "https://apple.com")!
        webView.load(URLRequest(url: url))
        
        webView.layer.borderColor = UIColor.blue.cgColor
        selectWebView(webView)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
    }
    
    func selectWebView(_ webView: WKWebView) {
        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        
        activeWebView = webView
        webView.layer.borderWidth = 3
    }
    
    @objc private func webViewTapped(_ recognizer: UITapGestureRecognizer) {
        if let selectedWebView = recognizer.view as? WKWebView {
            selectWebView(selectedWebView)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        webViewTapped(gestureRecognizer as! UITapGestureRecognizer)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let webView = activeWebView, let address = addressBar.text {
            if let url = URL(string: address) {
                webView.load(URLRequest(url: url))
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @objc private func deleteBrowser() {

    }

}

