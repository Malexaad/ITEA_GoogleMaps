//
//  WebViewController.swift
//  ITEA_GoogleMaps
//
//  Created by Alex Marfutin on 6/27/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var myWebKitView: WKWebView!
    @IBOutlet var urlText: UITextField!
    
    var urlRequest : URLRequest?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let request = urlRequest else {
            return
        }
        myWebKitView.load(request)
    }
    
    @IBAction func didTapAdressButtonSearch(_ sender: Any) {
        let myURL = URL(string: urlText.text!)
        let myRequest = URLRequest(url: myURL!)
        myWebKitView.load(myRequest)
    }
}
