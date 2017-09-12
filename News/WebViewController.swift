//
//  WebViewController.swift
//  News
//
//  Created by Amrita V on 8/15/17.
//  Copyright © 2017 Amrita Venkatraman. All rights reserved.
//

import Foundation
import UIKit


class WebViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!
    
    var url : String?
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.loadRequest(URLRequest(url: URL(string: url!)!))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ReaderController") as! ReaderController
       // myVC.searchTerm = searchTerm.text!
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    
}
