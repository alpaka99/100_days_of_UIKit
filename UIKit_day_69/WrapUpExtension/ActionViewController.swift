//
//  ActionViewController.swift
//  WrapUpExtension
//
//  Created by user on 2023/08/16.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    @IBOutlet var script: UITextView!
    

    var pageTitle = ""
    var pageURL = ""
    var tableContents: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        let userDefaults = UserDefaults()
        tableContents = userDefaults.value(forKey: "savedData") as? [String] ?? [String]()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: UTType.propertyList.identifier as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    let title = javaScriptValues["title"] as? String
                    let url = javaScriptValues["URL"] as? String
                    
                    self?.pageTitle = title ?? ""
                    self?.pageURL = url ?? ""
                    
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(preWritten))
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        addTableContent(url: script.text)
        
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: UTType.propertyList.identifier as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func preWritten() {
        let ac = UIAlertController(title: "Prewritten examples", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Show Hello world!", style: .default) { [weak self] _ in
            self?.script.text = "alert(\"Hello world\")"
        })
        ac.addAction(UIAlertAction(title: "Show site title", style: .default) { [weak self] _ in
            self?.script.text = "alert(document.title)"
        })
        ac.addAction(UIAlertAction(title: "Show site URL", style: .default) { [weak self] _ in
            self?.script.text = "alert(document.url)"
        })
        ac.addAction(UIAlertAction(title: "Go to Apple Developer Academy(KR)🍎", style: .default) { [weak self] _ in
            self?.script.text = "location.href='https://developeracademy.postech.ac.kr/'"
        })
        
        present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "URLCell", for: indexPath) as! URLCell
        cell.label.text = tableContents[indexPath.row]
        return cell
    }
    
    func addTableContent(url: String?) {
        guard let url = url else { return }
        tableContents.append(url)
        table.reloadData()
        
        let userDefaults = UserDefaults()
        userDefaults.set(tableContents, forKey: "savedData")
//        userDefaults.set([String](), forKey: "savedData")
    }
}
