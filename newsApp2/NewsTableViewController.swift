//
//  NewsTableViewController.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    
    lazy var header = HeaderView(width: self.view.bounds.width , height: self.view.bounds.height*0.17)
    
    var newsArray = [Result]()
    
    var newsCount = 0
    
    var totalResults = 0
    
    var parametrs = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
        header.delegate = self
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
            HeaderView.resultLabel.text = "result : " + "\(totalResults)"
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
    }
    
    private func fetchSourceNews(param: [String: String]) {
        
        self.networkDataFetcher.fetchSourceNews(param: param) { [self] (searchResults) in
            
            if searchResults?.status == "error" {
                let text = searchResults?.message
                print(text!)
            }
            
            guard let news = searchResults?.results else { return }
            
            newsArray = news
            newsCount = news.count
            totalResults = searchResults?.totalResults ?? 0
            HeaderView.resultLabel.text = "result : " + "\(totalResults)"
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.view.bounds.height*0.17
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.setupCell(result: newsArray[indexPath.row])
//        cell.photoImageView.layer.opacity = 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewViewController()
        vc.setupViewController(result: newsArray[indexPath.row])
        self.present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsTableViewController: HeaderViewDelegate {
    func chooseParam(section: Int, row: Int) {
        switch section {
        case 0:
            if row != 0{
                parametrs["country"] = "\(Country.countryesArray[row])"
            } else {
                parametrs["country"] = nil
            }
        case 1:
            if row != 0{
                parametrs["category"] = "\(Category.categoryArray[row])"
            } else {
                parametrs["category"] = nil
            }
        default:
            if row != 0{
                parametrs["language"] = "\(Language.languagesArray[row])"
            } else {
                parametrs["language"] = nil
            }
        }
        
        fetchSourceNews(param: parametrs)
        
    }

}





