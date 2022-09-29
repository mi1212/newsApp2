//
//  HeaderView.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 29.09.2022.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func chooseParam(section: Int, row: Int)
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    var height: CGFloat = 0
    
    var width: CGFloat = 0
    
    private lazy var blurView: UIView = {
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
        setupHeader()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        self.addSubview(blurView)
        self.addSubview(buttonTableView)
        self.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonTableView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonTableView.bottomAnchor.constraint(equalTo: resultLabel.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: buttonTableView.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: height/4)
        ])
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
        cell.delegate = self
        cell.section = indexPath.section
        switch indexPath.section {
        case 0:
            cell.array = Country.countryesStringArray
        case 1:
            cell.array = Category.categoryStringArray
        default:
            cell.array = Language.languagesStringArray
        }
        return cell
        
    }
}

extension HeaderView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height/3
    }
}

extension HeaderView: HeaderViewCellDelegate {
    func chooseParam(section: Int, row: Int) {
        print("section \(section), row \(row)")
        delegate?.chooseParam(section: section, row: row)
    }
}


