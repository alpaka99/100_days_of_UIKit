//
//  TableView.swift
//  CustomTextView
//
//  Created by user on 11/10/23.
//

import Foundation
import UIKit

//class CustomTableView: UITableView {
//    private let cellId: String = "Cell"
//    
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        
////        tableView = UITableView(frame: .zero, style: .grouped)
////        self.allowsSelection = false
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


//class TableViewController: UITableViewController {
//    private let cellId: String = "Cell"
//    private var talkButton: UIButton!
//
//    // 즉시 최하단으로 이동하기 위한 버튼 -> 제작중
//    private var floatingButton: UIButton!
//
//    private func createFloatingButton() {
//        floatingButton = UIButton(type: .custom)
//        floatingButton?.backgroundColor = .systemBlue
//        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
////        constraintFloatingButtonToWindow()
//        floatingButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        floatingButton?.layer.cornerRadius = 33
//        floatingButton?.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//        floatingButton?.setTitleColor(.white, for: .normal)
//        floatingButton?.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
//    }
//
//    @objc func floatingButtonTapped() {
//        tableView.scrollToBottom(animated: false)
//    }
//
////    private func constraintFloatingButtonToWindow() {
////        DispatchQueue.main.async { [weak self] in
////            guard let keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow), let floatingButton = self?.floatingButton else { return }
////            keyWindow.addSubview(floatingButton)
////            keyWindow.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor, constant: 16).isActive = true
////            keyWindow.bottomAnchor.constraint(equalTo: floatingButton.bottomAnchor, constant: 16).isActive = true
////            print(keyWindow.safeAreaInsets.bottom)
////            floatingButton.widthAnchor.constraint(equalToConstant: 66).isActive = true
////            floatingButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
////        }
////    }
//
//    override func loadView() {
//        super.loadView()
//
//        // sticky header를 없애기 위해서 새로 UITableView를 만들어서 넣어줌
//        self.tableView = UITableView(frame: .zero, style: .grouped)
//        self.talkButton = UIButton()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
////        tableView.allowsSelection = false
////        tableView.separatorStyle = .none
////        tableView.backgroundColor = UIColor.systemGray6
////        tableView.canCancelContentTouches = false
////        tableView.estimatedSectionHeaderHeight = 0 // section header로 잡힌 높이만큼 안내려가던 거였음
//
//
//        createFloatingButton()
//        view.addSubview(floatingButton)
//    }
//
//
//    // 처음에 최하단으로 스크롤을 내리는 메서드
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.scrollToBottom(animated: false)
//    }
//
//    //
//    override func viewDidAppear(_ animated: Bool) {
//        print("\n\n")
//        print("contentSize.height: \(tableView.contentSize.height)") // content의 높이
//        print("frame.size.height: \(tableView.frame.size.height)") // tableView의 프레임의 높이
//        print("contentOffset.y: \(tableView.contentOffset.y)") // 내용물의 y축 오프셋 -> conten 높이 - 프레임 높이
//        print("\n\n")
//
//    }
//
//    // section 갯수 메서드
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return longMessages.count
//    }
//
//    // haeder section view를 결정하는 메서드
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = SectionHeaderView()
//
//        let containerView = UIView()
//        containerView.layer.cornerRadius = 8
//        containerView.addSubview(label)
//
//        label.dateLabel.text = longMessages[section].first?.date ?? "알 수 없는 날짜"
//        label.timeLabel.text = "01:29"
//
//        //        label.text = self.chatMessages[section].first?.date ?? "알 수 없는 날짜"
//
//        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//
//        return containerView
//    }
//
//    // header section의 높이에 대한 메서드
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
//
//    // tableView가 몇개의 cell을 만들건지에 대한 메서드
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return longMessages[section].count
//    }
//
//    // tableView의 각 cell에 대한 메서드
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
//        cell.chatMessage = longMessages[indexPath.section][indexPath.row]
//
//        cell.contentView.isHidden = true
//        cell.contentView.alpha = 0
//        return cell
//    }
//
//    // 스와이프해서 아래로 이동하기 위한 메서드
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let height = scrollView.frame.size.height // 화면 안의 tableView의 frame size
//        let contentYOffset = scrollView.contentOffset.y // tableView 내부의 content가 얼마나 이동했는지 계산
//        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
//
//        if distanceFromBottom + 100 < height {
//            let ac = UIAlertController(title: "Swipe up detected", message: "Moving to lower view", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//
//    // floating button을 넣기 위한 메서드
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // floatingButton
//
//        if tableView.contentOffset.y + tableView.frame.size.height + 500 < tableView.contentSize.height { // floating button 보이기
////            //            print("Give me floating button")
//            UIView.animate(withDuration: 0.2) {
//                self.floatingButton?.isHidden = false
//                self.floatingButton?.alpha = 1
//            }
//        } else { // floating button 안보이기
//            UIView.animate(withDuration: 0.2) {
//                self.floatingButton?.isHidden = true
//                self.floatingButton?.alpha = 0
//            }
//        }
//    }
//}



