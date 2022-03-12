//
//  WKWebViewController+.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 27.02.2022.
//

import UIKit
import WebKit

extension WKWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"] else { return }
        
        session.token = token
        let sessionJSON = vkJSON(token: session.token)
        
        print(token)
//        sessionJSON.getFriends { friends in
//            print(friends.count)
//            friends.forEach({ print($0.last_name)})
//            friends.forEach({ print($0)})
//        }
//        sessionJSON.getList(of: .photos)
//        sessionJSON.getList(of: .groups)
//        sessionJSON.getList(of: .groupOf)
        
        decisionHandler(.cancel)
        
        let tabBarController = TabBarViewController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}
