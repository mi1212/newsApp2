//
//  HeaderView.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 29.09.2022.
//

import UIKit

class HeaderView: UIView {
    
    var height: CGFloat = 0
    
    var width: CGFloat = 0
    
    private lazy var sourcesView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        return view
    }()
    
    private lazy var buttonTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .green
        table.register(HeaderViewCell.self, forCellReuseIdentifier: "headercell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
        
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "result"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    convenience init(width: CGFloat, height: CGFloat) {
        self.init()
        self.width = width
        self.height = height
//        self.translatesAutoresizingMaskIntoConstraints = false
        setupHeader()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        self.addSubview(sourcesView)
        self.addSubview(buttonTableView)
        self.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            sourcesView.topAnchor.constraint(equalTo: self.topAnchor),
            sourcesView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sourcesView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sourcesView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonTableView.topAnchor.constraint(equalTo: sourcesView.topAnchor),
            buttonTableView.leadingAnchor.constraint(equalTo: sourcesView.leadingAnchor),
            buttonTableView.trailingAnchor.constraint(equalTo: sourcesView.trailingAnchor),
            buttonTableView.bottomAnchor.constraint(equalTo: resultLabel.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: buttonTableView.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: sourcesView.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: sourcesView.trailingAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: sourcesView.bottomAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: height/4)
        ])
    }
    
    private func pressCell(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}

extension HeaderView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headercell", for: indexPath) as! HeaderViewCell
        switch indexPath.section {
        case 0:
            cell.array = Country.countryesArray
        case 1:
            cell.array = Category.categoryArray
        default:
            cell.array = Language.languagesArray
        }
        return cell
        
    }
}

extension HeaderView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height/3
    }
}
