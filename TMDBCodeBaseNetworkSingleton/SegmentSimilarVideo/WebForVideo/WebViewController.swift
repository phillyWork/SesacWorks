//
//  WebViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/09/04.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
       
    var webView: WKWebView!
    
    let toolbar = {
        let bar = UIToolbar()
        return bar
    }()
    
    var video: Video?
    
    override func loadView() {
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configViews() {
        super.configViews()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        view.addSubview(toolbar)
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.forward"), style: .plain, target: self, action: #selector(forwardButtonTapped))
        let reloadButton = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(reloadButtonTapped))
        let leftSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [backButton, leftSpacer, reloadButton, rightSpacer, forwardButton]
        
        setupYoutubeView()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        toolbar.snp.makeConstraints { make in
            make.bottom.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func setupYoutubeView() {
        guard let video = video, let url = URL(string: URL.makeYoutubeURLString(video.key)) else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func backButtonTapped() {
        webView.reload()
    }
    
    @objc func forwardButtonTapped() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func reloadButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
}

//MARK: - Extension for WebView UIDelegate

extension WebViewController: WKUIDelegate {

}
