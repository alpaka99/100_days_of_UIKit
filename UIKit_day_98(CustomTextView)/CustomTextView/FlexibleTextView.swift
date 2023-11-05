//
//  FlexibleTextView.swift
//  CustomTextView
//
//  Created by user on 2023/11/05.
//

import SwiftUI
import UIKit

struct ChatMessage {
    let text: String
    let textType: TextType
    let date: String
}

class DateHeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.systemBlue
        font = .boldSystemFont(ofSize: 16)
        
        textAlignment = .center
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let width = originalContentSize.width + 24
        let height = originalContentSize.height + 20
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: width, height: height)
    }
    
}

struct ChatViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let tableViewController = TableViewController()
        return tableViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class TableViewController: UITableViewController {
    private let cellId = "Cell"
    let chatMessages: [[ChatMessage]] = [
        [
            ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25"),
         ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
        ],
        [
            ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
            ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
            ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26")
        ],
        [
            ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
             ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27"),
            ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
             ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27")
        ],
        [
            ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
            ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/28"),
            ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
            ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "History"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.systemGray4
        tableView.canCancelContentTouches = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = DateHeaderLabel()
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.addSubview(label)
        
        label.text = self.chatMessages[section].first?.date ?? "알 수 없는 날짜"
        
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        return containerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.chatMessage = chatMessages[indexPath.section][indexPath.row]
        
        cell.contentView.isHidden = true
        cell.contentView.alpha = 0
        return cell
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom < height {
//            print("reached bottom")
        }
    }
}

class FlexibleTextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}




struct TestChatView: View {
    var body: some View {
        ChatViewControllerRepresentable()
    }
}


struct TestChatView_Preview: PreviewProvider {
    
    static var previews: some View {
        TestChatView()
    }
}
