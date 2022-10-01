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
    
    private var timer: Timer?
    
    var parametrs = [String: String]()
    // обновление при скролле вниз
    var refresherControl:UIRefreshControl!
    
    private func setupRefresh() {
        refresherControl = UIRefreshControl()
        self.refresherControl?.tintColor = .black
        self.tableView.alwaysBounceVertical = true
        self.refresherControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.tableView.addSubview(refresherControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews(nextPage: false)
        setupRefresh()
        header.delegate = self
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    private func fetchNews(nextPage: Bool) {
        self.networkDataFetcher.fetchNews(nextPage: nextPage) { [self] (searchResults) in
            
            if searchResults?.status == "error" {
                let text = searchResults?.message
                print(text as Any)
            }
            
            guard let news = searchResults?.results else { return }
            
            totalResults = searchResults?.totalResults ?? 0
            
            switch nextPage {
            case true:
                newsArray += news
                newsCount += news.count
                totalResults = (searchResults?.totalResults)!
                print("\\case true  newsArray.count  - \(newsArray.count)")
                
            case false:
                
                newsArray = news
                newsCount = news.count
                totalResults = (searchResults?.totalResults)!
                print("\\case false  newsArray.count  - \(newsArray.count)")
            }
            
            HeaderView.resultLabel.text = "result : " + "\(totalResults)"
            
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
    }
    
    private func fetchSourceNews(nextPage: Bool, param: [String: String]) {
        
        self.networkDataFetcher.fetchSourceNews(nextPage: nextPage, param: param) { [self] (searchResults) in
            
            if searchResults?.status == "error" {
                let text = searchResults?.message
                print(text!)
            }
            
            guard let news = searchResults?.results else { return }
            
            switch nextPage {
                
            case true:
                newsArray += news
                newsCount += news.count
                totalResults = (searchResults?.totalResults)!
                
                print("\\case true  newsArray.count  - \(newsArray.count)")
                
            case false:
                
                newsArray = news
                newsCount = news.count
                totalResults = (searchResults?.totalResults)!
                
                print("\\case false  newsArray.count  - \(newsArray.count)")
            }
            
            print("totalResult \(totalResults)")
            HeaderView.resultLabel.text = "result : " + "\(totalResults)"
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
        
    }
    
    @objc func loadData() {
        if parametrs.isEmpty {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [self] _ in
                fetchNews(nextPage: false)
                tableView.reloadData()
                refresherControl.endRefreshing()
            })
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [self] _ in
                fetchSourceNews(nextPage: false, param: parametrs)
                tableView.reloadData()
                refresherControl.endRefreshing()
            })
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewViewController()
        vc.setupViewController(result: newsArray[indexPath.row])
        self.present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isAtBottom {
            if totalResults != newsArray.count {
                if parametrs.isEmpty {
                    fetchNews(nextPage: true)
                } else {
                    fetchSourceNews(nextPage: true, param: parametrs)
                }
            } else {
                print("news was ended")
            }
        }
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
        tableView.setContentOffset(.zero, animated: true)
        fetchSourceNews(nextPage: false, param: parametrs)
        
    }

}





