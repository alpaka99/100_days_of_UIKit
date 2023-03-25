//
//  DetailViewController.swift
//  UIKit_day_25
//
//  Created by user on 2023/03/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var website: String?
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://\(website!).com")!
        webView.load(URLRequest(url: url))
        
        title = website ?? "No website passed from parent"
        // Do any additional setup after loading the view.
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(forward))
        let backward = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(backward))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer , refresh, backward, forward]
        
        navigationController?.isToolbarHidden = false
    }
    
    @objc func forward() {
        webView.goForward()
    }
    
    @objc func backward() {
        webView.goBack()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress) // progressview 에 값을 전달해야하니깐... progressview 가 어떤걸 기준으로 바를 채울지 모르자나
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
//            print(host)
            if host.contains(website!) {
//                print(host, website!)
                decisionHandler(.allow)
                return
            }
        }
        
        guard let host = url?.host else {
            decisionHandler(.allow)
            return
        }
        
        if host.contains(website!) {
            decisionHandler(.allow)
            return
        }
        
        print(host)
        
        let alert = UIAlertController(title: "Not allowed website", message: "The web you want to enter is not allowed", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        decisionHandler(.cancel)
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
