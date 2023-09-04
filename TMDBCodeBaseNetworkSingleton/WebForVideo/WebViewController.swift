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
        
        setupYoutubeView()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    private func setupYoutubeView() {
        guard let video = video, let url = URL(string: URL.makeYoutubeURLString(video.key)) else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
}

//MARK: - Extension for WebView UIDelegate

extension WebViewController: WKUIDelegate {

}
