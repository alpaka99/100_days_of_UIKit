//
//  ChatMessageCell.swift
//  CustomTextView
//
//  Created by user on 2023/11/05.
//

import CoreText
import UIKit

enum TextType {
    case inComming
    case outGoing
}

class ChatMessageCell: UITableViewCell, UITextViewDelegate {
    let bubbleBackgroundView: UIView =  UIView()
    var textView: UITextView = UITextView()
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            textView.text = chatMessage.text
            
            switch chatMessage.textType {
            case .inComming:
                bubbleBackgroundView.backgroundColor = .orange
                textView.textColor = .white
                textView.font = UIFont.systemFont(ofSize: 17, weight: .bold)
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                
            case .outGoing:
                bubbleBackgroundView.backgroundColor = .white
                textView.textColor = .black
                textView.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        bubbleBackgroundView.layer.cornerRadius = 8
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        
        // textView
        addSubview(textView)
        
        textView.font = UIFont(name: textView.font?.fontName ?? "", size: 100)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.delegate = self
        
        // setup constraints
        let constraints = [
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            textView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.8, constant: -40),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: textView.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 16),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32)
        leadingConstraint.isActive = true
        
        trailingConstraint = textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textView(_ textView: UITextView, editMenuForTextIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        var additionalActions: [UIMenuElement] = [UIMenuElement]()
        
        let selectedWord = (textView.text as NSString).substring(with: range)
        
        let copyAction = UIAction(title: "복사하기", image: UIImage(systemName: "doc.on.doc")) { value in
            print(selectedWord)
        }
        additionalActions.append(copyAction)
        
        let searchAction = UIAction(image: UIImage(systemName: "magnifyingglass")) { _ in
            UIApplication.shared.openURL(URL(string: "https://google.com/search?q=\(selectedWord)")!)
        }
        additionalActions.append(searchAction)
        
        let instantPasteAction = UIAction(title: "바로 붙혀넣기", image: UIImage(systemName: "doc.on.clipboard")) { _ in
            
        }
        additionalActions.append(instantPasteAction)
        
        let allWayAction = UIAction(title: "AllWay 화이팅") { _ in
            print("모코레첼롄매린지 == Team AllWay :)")
        }
        additionalActions.append(allWayAction)
        
        let menu = UIMenu(options: .displayAsPalette, children: additionalActions)
        
        return menu
    }
}
