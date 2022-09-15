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
    
    var sourcesArray = Category.CategoryArray
    
    var source = Category.business
    
    private lazy var sourcesView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white
        let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    private lazy var sourcesCollectionView: UICollectionView = {
        let inset: CGFloat = 10
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: self.view.layer.bounds.width, height: self.view.layer.bounds.height/6)
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: "SourseCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.contentInsetAdjustmentBehavior = .never
        return collection
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
            resultLabel.text = "results \(totalResults)"
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
    }
    
    private func fetchSourceNews(id: String) {
        self.networkDataFetcher.fetchSourceNews(id: id) { [self] (searchResults) in
            
            if searchResults?.status == "error" {
                let text = searchResults?.message
                print(text!)
            }
            
            guard let news = searchResults?.results else { return }
            
            newsArray = news
            newsCount = news.count
            totalResults = searchResults?.totalResults ?? 0
            resultLabel.text = "results \(totalResults)"
            tableView.rowHeight = self.view.layer.bounds.height/6
            tableView.reloadData()
        }
    }
    
    private func setupHeader() {
        sourcesView.addSubview(sourcesCollectionView)
        sourcesView.addSubview(resultLabel)
        
        
        NSLayoutConstraint.activate([
            sourcesCollectionView.topAnchor.constraint(equalTo: self.sourcesView.topAnchor),
            sourcesCollectionView.leadingAnchor.constraint(equalTo: self.sourcesView.leadingAnchor),
            sourcesCollectionView.trailingAnchor.constraint(equalTo: self.sourcesView.trailingAnchor),
            sourcesCollectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/12*0.6),
        ])
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: self.sourcesCollectionView.bottomAnchor, constant: self.view.bounds.height/140),
            resultLabel.centerXAnchor.constraint(equalTo: self.sourcesView.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: self.sourcesView.bottomAnchor, constant: -self.view.bounds.height/140),
        ])
        
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

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "results \(totalResults)"
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupHeader()
        return sourcesView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.view.bounds.height/12
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

extension NewsTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange
        fetchSourceNews(id: sourcesArray[indexPath.row])
        self.tableView.reloadData()
    }
}


extension NewsTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sourcesArray.count
//        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourseCell", for: indexPath) as! SourcesCollectionViewCell
//        cell.backgroundColor = .systemCyan
        cell.label.text = sourcesArray[indexPath.row]
        return cell
    }
    
    
}

//extension NewsTableViewController: UIScrollViewDelegate {
//
//}
