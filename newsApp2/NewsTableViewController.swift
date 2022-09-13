//
//  NewsTableViewController.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    let networkDataFetcher = NetworkDataFetcher()
    
    var newsArray = [Result]()
    
    var newsCount = 0
    
    var totalResults = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    private func fetchNews() {
        self.networkDataFetcher.fetchNews() { [self] (searchResults) in
            
            if searchResults?.status == "error" {
                let text = searchResults?.message
                print(text as Any)
            }
            
            guard let news = searchResults?.results else { return }
            newsArray = news
            newsCount = news.count
            totalResults = searchResults?.totalResults ?? 0
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == newsArray.count {
            print("do something")
            
            self.networkDataFetcher.fetchNews() { [self] (searchResults) in

                if searchResults?.status == "error" {
                    let text = searchResults?.message
                    print(text as Any)
                }

                guard let news = searchResults?.results else { return }
//                print(news)
                for i in 0...news.count-1 {
                    newsArray.insert(news[i], at: newsCount + i)
//                    print(newsArray.count)
                }
        }
            
            newsCount = newsArray.count
            print(newsCount)
            self.tableView.reloadData()
    }
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "results \(totalResults)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.setupCell(result: newsArray[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewViewController()
        vc.setupViewController(result: newsArray[indexPath.row])
        self.present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

//extension NewsTableViewController: UIScrollViewDelegate {
//
//}
