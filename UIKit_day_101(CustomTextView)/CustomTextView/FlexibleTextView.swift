//
//  FlexibleTextView.swift
//  CustomTextView
//
//  Created by user on 2023/11/05.
//

import Combine
import Foundation
import SwiftUI
import UIKit

public struct ChatMessage {
    let text: String
    let textType: TextType
    let date: String
}

struct ChatViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let historyViewController = HistoryViewController()
        return historyViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


struct TestChatView: View {
    @State private var showHistoryView: Bool = true
    @State private var showWebSheet: Bool = false
    @State var webURL: URL?
    
    let swipeDetectNotification = Notification.Name("swipeDetected")
    let webViewNotification = Notification.Name("webViewNotification")
    
    var body: some View {
        VStack {
            switch showHistoryView {
            case true:
                VStack {
                    ChatViewControllerRepresentable()
                    Button {
                        
                    } label: {
                        VStack {
                            Text("작성화면으로 돌아가기")
                                .font(.footnote)
                            Image(systemName: "chevron.down")
                                .resizable()    .frame(width: 32, height: 10)
                        }
                    }
                }
                .padding()
                
            case false:
                VStack {
                    Text("Reached Typing View")
                }
                .padding()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: swipeDetectNotification)) { _ in
            showHistoryView = false
        }
        .onReceive(NotificationCenter.default.publisher(for: webViewNotification, object: nil), perform: { data in
            print("noti")
            if let url = data.object as? URL {
                webURL = url
                if webURL != nil {
                    showWebSheet = true
                }
            } else {
                print("cannot convert url")
            }
        })
        .sheet(isPresented: $showWebSheet) {
            ShitWebView(webURL: $webURL)
        }
    }
    
    func loadURL(_ url: URL?, completionHandler:  @escaping () -> Void) {
        guard let url = url else { return }
        webURL = url
        completionHandler()
    }
}
    
struct TestChatView_Preview: PreviewProvider {
    static var previews: some View {
        TestChatView()
    }
}

    
