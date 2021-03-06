//
//  VKLoginViewController.swift
//  VK_client
//
//  Created by Ekaterina Donskaya on 26/09/2020.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit
import WebKit
import FirebaseAuth
import SwiftKeychainWrapper

class VKLoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7609950"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends, wall, photos"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.124")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webview.load(request)
        
    }
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"], let userId = params["user_id"] else { return }
        Session.instance.token = token
        Session.instance.userId = userId
        debugPrint(token)
        
        decisionHandler(.cancel)
        
        Auth.auth().signIn(withEmail: "katrine.d@gmail.com", password: "123456")
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController: UITabBarController = (storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController) {
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true, completion: nil)
            
        }
    }
    
}


