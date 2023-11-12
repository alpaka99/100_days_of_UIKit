//
//  ShitWebView.swift
//  CustomTextView
//
//  Created by user on 11/12/23.
//

import SwiftUI
import WebKit

struct ShitWebView: UIViewRepresentable {
    @Binding var webURL: URL?
    let webView: WKWebView = WKWebView()
    
    func makeUIView(context: Context) -> some UIView {
//        print("Make")
//        print("Inside \(webURL)")
        guard let url = webURL else {
            webView.load(URLRequest(url: URL(string: "https://google.com")!))
            return webView
        }
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("update")
        print("updatedURL: \(webURL)")
        guard let url = webURL else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
}

//#Preview {
//    ShitWebView()
//}
