//
//  WebViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
//    var webView: WKWebView!
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }

    //초기화 활용
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //custom하게 webview 활용
        //addSubView 및 constraint 설정
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //navigationController: 시작은 투명, 스크롤하면 불투명
        //UI 및 attribute 설정: apperance 활용 ~ navbar, tabbar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        
        //투명도 설정 --> layout이 navigation 밑에서 시작
        navigationController?.navigationBar.isTranslucent = false
        
        //scroll 상관없이 동일하게 적용하기
        //standard: scroll 시작
        //scrolledge: scoll 영역에 모서리 닿은 겨우
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        title = "This is webview"
    }
    
    
    //toolbar 같이 활용 가능

    //새로고침
    func reloadButtonTapped() {
        webView.reload()
    }
    
    //이전 화면 가기
    func goBackButtonTapped() {
        if webView.canGoBack {      //이전 page history 존재할 경우
            webView.goBack()
        }
    }
    
    //다음 화면 가기
    func goForwardButtonTapped() {
        if webView.canGoForward {   //앞으로 돌아갈 수 있는 page history 존재할 경우
            webView.goForward()
        }
    }
    
    
    
    
}
