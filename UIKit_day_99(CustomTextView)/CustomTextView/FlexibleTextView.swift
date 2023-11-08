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

class DateHeaderLabel: UIView {
    let dateLabel: UILabel = UILabel()
    let divider: UIView = UIView()
    let timeLabel: UILabel = UILabel()
    let backgroundView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel.text = "23/11/07" // 임시로 넣어둔 값인데 수정하고 싶다
        dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        divider.frame = CGRect(x: 0, y: 0, width: 300, height: 2)
        divider.layer.borderWidth = 1
        divider.layer.borderColor = UIColor.systemGray3.cgColor
        
        backgroundView.backgroundColor = UIColor.systemGray6
        backgroundView.layer.opacity = 0.5
        
        timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        timeLabel.textColor = UIColor.systemGray
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        
        addSubview(dateLabel)
        addSubview(divider)
        addSubview(timeLabel)
        
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: dateLabel.intrinsicContentSize.height),
            
            divider.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            divider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            divider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            divider.heightAnchor.constraint(equalToConstant: divider.frame.size.height),
            
            timeLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


struct ChatViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let tableViewController = TableViewController()
        return tableViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @Binding var isBottom: Bool
    @Binding var showWebView: Bool
}

class TableViewController: UITableViewController {
    private let cellId = "Cell"
    // short
        let chatMessages: [[ChatMessage]] = [
            [
                ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25")
//             ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
            ]
        ]
    
    // middle
//    let chatMessages: [[ChatMessage]] = [
//        [
//            ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25"),
//            ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
//        ],
//        [
//            ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
//            ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
//            ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26")
//        ],
//        [
//            ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
//            ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27"),
//            ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
//            ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27")
//        ],
//        [
//            ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
//            ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/28"),
//            ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
//            ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
//        ],
//    ]
    
    // long
//        let chatMessages: [[ChatMessage]] = [
//            [
//                ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25"),
//             ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
//            ],
//            [
//                ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
//                ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
//                ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26")
//            ],
//            [
//                ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
//                 ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27"),
//                ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
//                 ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27")
//            ],
//            [
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/28"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
//            ],
//            [
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/29"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/29"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/29"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/29"),
//            ],
//            [
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/30"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/30"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/30"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/30"),
//            ],
//            [
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/31"),
//                ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31"),
//                ChatMessage(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla condimentum accumsan nisl et lobortis. Donec magna enim, pulvinar vel pellentesque eget, ultricies non urna. Nullam in laoreet enim. Maecenas ut maximus nisi. Aenean fermentum, lorem eget cursus tincidunt, justo nunc pharetra leo, in tincidunt orci purus a tortor. Donec et lectus molestie, efficitur sapien vel, euismod nisl. Maecenas quis diam a ante maximus feugiat nec et nibh. Aliquam in nunc ante. Duis id nunc eget arcu euismod interdum sit amet nec mauris. Nam at tortor in arcu laoreet semper vel vitae elit. Vivamus vitae nibh eu justo aliquam euismod. In vulputate enim et bibendum dictum. Quisque eros urna, tempor fermentum laoreet id, eleifend sit amet neque. Aenean auctor felis gravida sapien auctor dictum. Proin eu nulla sed eros efficitur varius sed ut lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor neque id pharetra facilisis. Quisque ac luctus ante. Nunc sed urna tempus, rhoncus libero nec, bibendum nisi. Vestibulum vitae enim quam. Sed dolor nisl, gravida eu commodo ac, aliquam sed purus. Vivamus a erat vel arcu venenatis semper. Nullam urna odio, ultrices ut elit at, sodales congue magna. In hac habitasse platea dictumst. Proin nec efficitur lectus, at ullamcorper nulla. Donec sollicitudin luctus posuere. Aliquam faucibus eros id erat tristique porta. In hendrerit faucibus leo eget ullamcorper. Quisque laoreet erat at lacus pellentesque sodales. Suspendisse semper sem elit, sed faucibus ante sagittis quis. Ut suscipit dolor gravida mollis egestas. Sed arcu lectus, ornare vel ante sed, congue volutpat purus. Etiam vestibulum id mauris eget finibus. Nullam ac suscipit turpis, nec pellentesque turpis. Nunc vitae finibus neque. Morbi dapibus sit amet nisl facilisis tempus. Phasellus gravida dolor sed neque porttitor, porttitor placerat arcu venenatis. Praesent mattis sagittis risus, elementum finibus quam pretium id. Donec non euismod lorem, quis fringilla nunc. Curabitur in nunc velit. Donec ultrices orci urna, non vestibulum orci consequat et. Sed at tortor ac nibh varius porta eu in nibh. Morbi dapibus purus libero, a gravida leo aliquet sed. Donec euismod, urna porta pellentesque scelerisque, ex enim sagittis leo, vitae scelerisque tortor ligula non tellus. Pellentesque id auctor est. Donec mattis sem non condimentum dictum. Aliquam vel cursus nisl, eu congue nisi. Nam tortor quam, malesuada vitae efficitur vel, commodo eget lorem. Aliquam erat volutpat. Maecenas lobortis, sem eu egestas lacinia, est elit semper quam, in sollicitudin mauris nibh in sapien. Mauris pharetra eget lorem in ultrices.", textType: .outGoing, date: "23/05/31"),
//            ]
//        ]
    // 즉시 최하단으로 이동하기 위한 버튼 -> 제작중
    private var floatingButton: UIButton?
    
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.backgroundColor = .systemBlue
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        constraintFloatingButtonToWindow()
        floatingButton?.layer.cornerRadius = 33
        floatingButton?.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        floatingButton?.setTitleColor(.white, for: .normal)
        floatingButton?.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingButtonTapped() {
        tableView.scrollToBottom(animated: false)
    }
    
    private func constraintFloatingButtonToWindow() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow), let floatingButton = self.floatingButton else { return }
            keyWindow.addSubview(floatingButton)
            keyWindow.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor, constant: 20).isActive = true
            keyWindow.bottomAnchor.constraint(equalTo: floatingButton.bottomAnchor, constant: 20).isActive = true
            
            floatingButton.widthAnchor.constraint(equalToConstant: 66).isActive = true
            floatingButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        }
    }
    
    override func loadView() {
        super.loadView()
        
        // sticky header를 없애기 위해서 새로 UITableView를 만들어서 넣어줌
        self.tableView = UITableView(frame: .zero, style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.systemGray6
        tableView.canCancelContentTouches = false
        tableView.estimatedSectionHeaderHeight = 0 // section header로 잡힌 높이만큼 안내려가던 거였음
        
        createFloatingButton()
    }
    
    
    // 처음에 최하단으로 스크롤을 내리는 메서드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.scrollToBottom(animated: false)
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        print("\n\n")
        print("contentSize.height: \(tableView.contentSize.height)") // content의 높이
        print("frame.size.height: \(tableView.frame.size.height)") // tableView의 프레임의 높이
        print("contentOffset.y: \(tableView.contentOffset.y)") // 내용물의 y축 오프셋 -> conten 높이 - 프레임 높이
        print("\n\n")
        
    }
    
    // section 갯수 메서드
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    // haeder section view를 결정하는 메서드
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = DateHeaderLabel()
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.addSubview(label)
        
        label.dateLabel.text = self.chatMessages[section].first?.date ?? "알 수 없는 날짜"
        label.timeLabel.text = "01:29"
        
        //        label.text = self.chatMessages[section].first?.date ?? "알 수 없는 날짜"
        
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        return containerView
    }
    
    // header section의 높이에 대한 메서드
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    // tableView가 몇개의 cell을 만들건지에 대한 메서드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    // tableView의 각 cell에 대한 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.chatMessage = chatMessages[indexPath.section][indexPath.row]
        
        cell.contentView.isHidden = true
        cell.contentView.alpha = 0
        return cell
    }
    
    // 스와이프해서 아래로 이동하기 위한 메서드
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height // 화면 안의 tableView의 frame size
        let contentYOffset = scrollView.contentOffset.y // tableView 내부의 content가 얼마나 이동했는지 계산
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom + 100 < height {
            let ac = UIAlertController(title: "Swipe up detected", message: "Moving to lower view", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // floating button을 넣기 위한 메서드
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.size.height + 500 < tableView.contentSize.height { // floating button 보이기
            //            print("Give me floating button")
            UIView.animate(withDuration: 0.2) {
                self.floatingButton?.isHidden = false
                self.floatingButton?.alpha = 1
            }
        } else { // floating button 안보이기
            UIView.animate(withDuration: 0.2) {
                self.floatingButton?.isHidden = true
                self.floatingButton?.alpha = 0
            }
        }
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool) {
        let sectionCount = numberOfSections - 1
        let rowCount = numberOfRows(inSection: sectionCount) - 1
        self.scrollToRow(at: IndexPath(row: rowCount, section: sectionCount), at: .bottom, animated: animated)
    }
}




struct TestChatView: View {
    @State var isBottom: Bool = false
    @State var showWebView: Bool = false
    var body: some View {
        ChatViewControllerRepresentable(isBottom: $isBottom, showWebView: $showWebView)
            .frame(height: 300)
            .sheet(isPresented: $isBottom) {
                VStack {
                    Text("Bottom")
                    Button("Cancel") {
                        isBottom = false
                    }
                }
            }
            .sheet(isPresented: $showWebView) {
                VStack {
                    Text("showWebView")
                    Button("Cancel") {
                        showWebView = false
                    }
                }
            }
    }
}


struct TestChatView_Preview: PreviewProvider {
    
    static var previews: some View {
        TestChatView()
    }
}
