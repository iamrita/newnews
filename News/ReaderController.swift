//
//  ReaderController.swift
//  News
//
//  Created by Amrita V on 8/15/17.
//  Copyright © 2017 Amrita Venkatraman. All rights reserved.
//

import Foundation
import UIKit

class ReaderController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var searchTerm = ""
    var time = ""
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Int(time)! * 200)
        fetchArticles()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func fetchArticles() {
        
        
        
            let urlRequest = URLRequest(url: URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=" + searchTerm + "&api-key=da5abf84e0fd424e9adb06bbdf9ee9bb")!)
        
        
        // article search api:
        // q= query
        // "https://newsapi.org/v1/articles?source=the-new-york-times&sortBy=top&apiKey=7849f4b2010146dc8041cb9235143b94"
       // https://api.nytimes.com/svc/search/v2/articlesearch.json?q=obama&api-key=da5abf84e0fd424e9adb06bbdf9ee9bb
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if (error != nil) {
                print(error)
                return
            }
            
            self.articles = [Article]()
            
            do {
               let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
               if let response = json["response"] as? [String: AnyObject],
                  let docs = response["docs"] as? [[String: AnyObject]] {
                
                   for doc in docs {
                      let article = Article()

                      if let url = doc["web_url"] as? String {
                       // print(url)
                        article.url = url
                      }
                    
                      if let desc = doc["snippet"] as? String{
                      //  print(desc)
                        article.desc = desc
                      }
                    
                    if  let headlines = doc["headline"] as? [String: AnyObject] {
                      if let printHeadline = headlines["print_headline"] as? String {
                       // print(printHeadline)
                        article.headline = printHeadline
                      }
                    }
                    
                    if let byline = doc["byline"] as? [String: AnyObject] {
                        if let author = byline["original"] as? String {
                          //  print(author)
                            article.author = author
                        }
                    }
                    
                    if  let multimedia = doc["multimedia"] as? [[String: AnyObject]] {
                    
                    for m in multimedia {
                        
                        let type = m["subtype"] as? String
                        if type == "thumbnail" {
                          if let imgUrl = m["url"] as? String{
                          // print(imgUrl)
                           article.imageUrl = "https://static01.nyt.com/"+imgUrl
                        }
                        }
                    }
                    }
                    
                    
                      if let wc = doc["word_count"] as? Int {
                        article.wordCount = wc
                        print(wc)
                      }
                    
                    
                    let intTime = (Int(self.time)!) * 200
                    if (abs(intTime - article.wordCount!) <= 300) {
                       self.articles?.append(article)
                    }
                   }
                }
                
                
                // let author = articleFromJson["author"] as? String
                //  let urlToImage = articleFromJson["urlToImage"] as? String
                
               /* if let articlesFromJson = json["articles"] as? [[String: AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["print_headline"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let wc = articleFromJson["word_count"] as? String {
                            
                           // article.author = author
                           // article.desc = desc
                            article.headline = title
                            article.url = url
                            article.wordCount = wc
                          //  article.imageUrl = urlToImage
                            
                            print(" headline is " + title)
                            print("url is " + url)
                            print("wordcount is " + wc)
                      
                        }
                        self.articles?.append(article)
                    }
                }*/
                
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()

                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        
        task.resume()
        
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
       // cell.title.text = "THIS IS A TEST"
        cell.title.text = self.articles?[indexPath.item].headline
        cell.author.text = self.articles?[indexPath.item].author
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)!)
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }
    
}


extension UIImageView {
    func downloadImage(from url: String) {
        
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            
            DispatchQueue.main.async {
                 
                    self.image = UIImage(data: data!)
                }
            }
          task.resume()
        }
        
        
        
}

