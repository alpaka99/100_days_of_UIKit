//
//  ViewController.swift
//  UIKit_day_17
//
//  Created by user on 2023/03/13.
//

import UIKit

class ViewController: UITableViewController { // 뒤에서는 사실 UITableViewController 도 UIViewController 위에서 동작함, class hierachy
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default // file manager 생성
        let path = Bundle.main.resourcePath! // 모든 컴파일된 코드와 리소스가 저장된 Bundle 을 path 로 지정
        let items = try! fm.contentsOfDirectory(atPath: path) // file manager 로 해당 path 에서 모든 리소스 꺼내오기
        
        for item in items { // 꺼내온 모든 리소스 중에서 nssl 이 붙은 사진 파일만 가져오기
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

