//
//  ThirdViewController.swift
//  SevenPlayer
//
//  Created by caiyangzhenyu on 16/11/21.
//  Copyright © 2016年 caiyangzhenyu. All rights reserved.
//

import UIKit
import WebKit
class ThirdViewController: UIViewController,WKScriptMessageHandler {
    lazy var webview = {WKWebView()}()
    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: "redHeader()",
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.add(
            self,
            name: "callbackHandler"
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webview = WKWebView(
            frame: view.frame,
            configuration: config
        )
         view.addSubview(webview)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlstr = "http://127.0.0.1:8080/assets/wkwebview.html"
        let url = URL.init(string: urlstr)
        webview.load(URLRequest.init(url: url!))
       
        
        // Do any additional setup after loading the view.
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler" {
            print(message.body)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
