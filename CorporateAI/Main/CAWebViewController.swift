//
//  CAWebViewController.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit
import WebKit

final class CAWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    let govUrl = "http://ncov.mohw.go.kr/tcmBoardList.do?brdId=3&brdGubun="

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUrl(govUrl)
    }

    private func loadUrl(_ string: String) {
        let url = URL(string: string)!
        let request = URLRequest(url: url)
        webView.load(request)
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }

    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }

    @IBAction func refresh(_ sender: Any) {
        webView.reload()
    }

    @IBAction func goHome(_ sender: Any) {
        loadUrl(govUrl)
    }


}
