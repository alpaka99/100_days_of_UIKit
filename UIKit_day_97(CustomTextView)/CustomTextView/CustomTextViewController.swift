//
//  CustomTextViewController.swift
//  CustomTextView
//
//  Created by user on 2023/11/03.
//

import SwiftUI
import UIKit

struct CustomTextView: UIViewControllerRepresentable {
    let text: String
    func makeUIViewController(context: Context) -> some UIViewController {
        let customTextViewController = CustomTextViewController()
        customTextViewController.text = text
        
        return customTextViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class CustomLabelView: UIViewController, UIEditMenuInteractionDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editMenuInteraction = UIEditMenuInteraction(delegate: self)
        view.addInteraction(editMenuInteraction)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapRecognizer.allowedTouchTypes = [UITouch.TouchType.direct.rawValue as NSNumber]
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTap(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self.view)
        
        
    }
}


class CustomTextViewController: UIViewController {
    var text: String!
    let myButton = UIButton()
    let topInset: CGFloat = 4.0
    let bottomInset: CGFloat = 4.0
    let leftInset: CGFloat = 8.0
    let rightInset: CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var scrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = self
        
        setView()
        
    }

    func setView() {
        let textView = UITextView()

        // textView attributes
        textView.text = text
        textView.autocorrectionType = .no
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.font = UIFont.preferredFont(forTextStyle: .title1)
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.adjustsFontForContentSizeCategory = true
        textView.textColor = .white
        textView.backgroundColor = .systemOrange
        
        textView.textContainerInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        
        
        textView.layer.cornerRadius = 12
        
        view.addSubview(textView)

        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        // programmatically making view
        textView.translatesAutoresizingMaskIntoConstraints = false

        textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: estimatedSize.height).isActive = true
        
        textView.delegate = self
        
        textViewDidChange(textView)
        
        // gesture
        let touchGesture = UIGestureRecognizer(target: self, action: #selector(didTap))
        touchGesture.delegate = self
        self.view.addGestureRecognizer(touchGesture)
    }
    
    @objc func didTap(_ recognizer: UIGestureRecognizer) {
        print(recognizer.numberOfTouches)
    }
}

extension CustomTextViewController: UITextViewDelegate, UIGestureRecognizerDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height + 100
            }
        }
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
        
        return UIMenu(children: additionalActions)
    }
}





//
//  ContentView.swift
//  CustomTextView
//
//  Created by user on 2023/11/03.
//

import SwiftUI

struct ContentView: View {
    let loop = ["asdf", "dafdsfasfd", "asdasdasd"]
    @State private var text: String = "asdasd"
    var body: some View {
        CustomTextView(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eu non diam phasellus vestibulum lorem sed risus. Rhoncus dolor purus non enim praesent. Turpis egestas sed tempus urna et pharetra. Semper risus in hendrerit gravida. Velit dignissim sodales ut eu sem integer vitae justo. Gravida in fermentum et sollicitudin ac orci phasellus egestas. Non nisi est sit amet facilisis magna etiam. Mattis nunc sed blandit libero volutpat sed cras ornare. In aliquam sem fringilla ut morbi tincidunt augue interdum.")
            .padding()
            
            //                CustomTextView(text: "레츠")
            //                    .padding()
            //
            //                CustomTextView(text: "레츠")
            //                    .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
