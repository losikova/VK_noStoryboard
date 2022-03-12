//
//  WKWebViewController+.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 27.02.2022.
//

import UIKit
import Alamofire
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
        print(token)
        
        getList(of: .friends)
        getList(of: .photos)
        getList(of: .groups)
        getList(of: .groupOf)
        
        decisionHandler(.cancel)
    }
    
    private func getList(of objects: Objects) {
        let baseUrl = "https://api.vk.com/method"
        
        var params: Parameters = [
            "access_token": session.token,
            "v": "5.131"
        ]
        
        if objects == .photos {
            params["album_id"] = "profile"
        }
        
        if objects == .groupOf {
            params["q"] = "Music"
        }
        
        let url = baseUrl + objects.rawValue
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { repsonse in
            print("\(objects): \(repsonse.value)")
        }
    }
}
