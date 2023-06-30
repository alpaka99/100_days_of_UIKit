//
//  DetailViewController.swift
//  UIKit_day_61
//
//  Created by user on 2023/07/01.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    @IBOutlet var webView: WKWebView!
    
    var capital: Capital?
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "\(capital?.title ?? "Unknown")"
        
        
        let wikiURL = "https://en.wikipedia.org/wiki/\(capital?.title?.localizedCapitalized ?? "Seoul")"
        let webURL = URL(string: wikiURL)
        let webRequest = URLRequest(url: webURL!)
        webView.load(webRequest)
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
