//
//  ViewController.swift
//  News
//
//  Created by Amrita V on 8/13/17.
//  Copyright © 2017 Amrita Venkatraman. All rights reserved.
//

import UIKit
//import Fuzi




class ViewController: UIViewController {
    
    @IBOutlet weak var searchTerm: UITextField!
 
    @IBOutlet weak var time: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        
        
        
     /*   let htmlUrl = URL(fileURLWithPath: ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("https://www.nytimes.com/2017/07/19/opinion/donald-trump-voting-rights-purge.html"))
        
        do {
            let data = try Data(contentsOf: htmlUrl)
            let document = try HTMLDocument(data: data)
            // get body of text
            if let body = document.xpath("//body").first?.stringValue {
                let cleanBody = clean(src: body)
                let trimmedBody = trim(src:cleanBody)
                print(trimmedBody.components(separatedBy: " ").count)
            }
        } catch {
            print(error)
        }*/

        // Do any additional setup after loading the view, typically from a nib.
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ReaderController") as! ReaderController
        myVC.searchTerm = searchTerm.text!
        myVC.time = time.text!
       navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    
 /*   // Trim
    func trim(src:String) -> String {
        return src.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // Remove Extra double spaces and new lines
    func clean(src:String) ->String {
        return src.replacingOccurrences(
            of: "\\s+",
            with: " ",
            options: .regularExpression)
    }*/
    
    
   
    



}

