//
//  ViewController.swift
//  UIKit_day_105(DiffableDataSource)
//
//  Created by user on 11/25/23.
//

import UIKit

class ViewController: UIViewController {
    var dataSource: UITableViewDiffableDataSource<Int, UUID>!
    var tableView: UITableView = UITableView()
    var appendButton: UIButton = UIButton()
    var deleteButton: UIButton = UIButton()
    let colors: [UIColor] = [.darkGray, .gray, .white, .red, .orange, .yellow, .green, .blue, .purple]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        appendButton.frame = CGRect(x: 0, y: 0, width: 250, height: 44)
        appendButton.backgroundColor = .blue
        appendButton.setTitle("Insert", for: .normal)
        appendButton.layer.cornerRadius = 20
        appendButton.titleLabel?.textColor = .white
        appendButton.addTarget(self, action: #selector(appendItem), for: .touchUpInside)
        appendButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(appendButton)
        
        deleteButton.frame = CGRect(x: 0, y: 0, width: 250, height: 44)
        deleteButton.backgroundColor = .red
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.layer.cornerRadius = 20
        deleteButton.titleLabel?.textColor = .white
        deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(deleteButton)
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        dataSource = UITableViewDiffableDataSource<Int, UUID>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            cell.backgroundColor = self.colors[indexPath.row % self.colors.count]
            cell.textLabel?.text = "\(indexPath.row)"
            
            return cell
        }
        
        tableView.dataSource = dataSource
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, UUID>()
        snapShot.appendSections([0]) // 주의: 섹션을 안넣어주면 에러
        snapShot.appendItems([UUID(), UUID()])
        dataSource.apply(snapShot)
        
        
        NSLayoutConstraint.activate([
            appendButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            appendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            appendButton.heightAnchor.constraint(equalToConstant: 44),
            appendButton.widthAnchor.constraint(equalToConstant: 250),
            
            deleteButton.bottomAnchor.constraint(equalTo: appendButton.topAnchor),
            deleteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.widthAnchor.constraint(equalToConstant: 250),
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor)
        ])
    }

    
    @objc func appendItem() {
        var snapShot = dataSource.snapshot()
        
        snapShot.appendItems([UUID()])
        dataSource.apply(snapShot)
    }
    
    @objc func deleteItem() {
        var snapShot = dataSource.snapshot()
        if let last = snapShot.itemIdentifiers.last {
            snapShot.deleteItems([last])
            dataSource.apply(snapShot)
        }
    }
}

