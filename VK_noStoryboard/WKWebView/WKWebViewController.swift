//
//  WKWebViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 27.02.2022.
//

import UIKit
import Alamofire
import WebKit

class WKWebViewController: UIViewController {
    
    var webView = WKWebView()
    let session = Session.instance
    
    enum Objects: String {
        case friends = "/friends.get"
        case photos = "/photos.get"
        case groups = "/groups.get"
        case groupOf = "/groups.search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupWeb()
    }
    
    private func setupUI() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        webView.clipsToBounds = true
    }
    
    private func setupWeb() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8089981"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
}
