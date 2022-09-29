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
    
    var countryesArray = Country.countryesArray
    
    var sourcesArray = Category.CategoryArray
    
    var languagesArray = Language.languagesArray
    
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
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.estimatedItemSize = CGSize(width: width/2, height: height/4)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var countryesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
//        collection.backgroundColor = .clear
        collection.register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: "SourseCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var sourcesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
//        collection.backgroundColor = .clear
        collection.register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: "SourseCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var languagesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
//        collection.backgroundColor = .clear
        collection.register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: "SourseCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
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
        self.addSubview(sourcesView)
        self.addSubview(countryesCollectionView)
        self.addSubview(sourcesCollectionView)
        self.addSubview(languagesCollectionView)
        self.addSubview(resultLabel)
        countryesCollectionView.collectionViewLayout.invalidateLayout()
        sourcesCollectionView.collectionViewLayout.invalidateLayout()
        sourcesCollectionView.collectionViewLayout.invalidateLayout()
        
        NSLayoutConstraint.activate([
            sourcesView.topAnchor.constraint(equalTo: self.topAnchor),
            sourcesView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sourcesView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sourcesView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            countryesCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            countryesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countryesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countryesCollectionView.heightAnchor.constraint(equalToConstant: height/4)
        ])
        
        NSLayoutConstraint.activate([
            sourcesCollectionView.topAnchor.constraint(equalTo: self.countryesCollectionView.bottomAnchor, constant: 2),
            sourcesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sourcesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sourcesCollectionView.heightAnchor.constraint(equalToConstant: height/4)
        ])
        
        NSLayoutConstraint.activate([
            languagesCollectionView.topAnchor.constraint(equalTo: self.sourcesCollectionView.bottomAnchor, constant: 2),
            languagesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            languagesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            languagesCollectionView.heightAnchor.constraint(equalToConstant: height/4)
        ])
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: self.languagesCollectionView.bottomAnchor, constant: 2),
            resultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
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

extension HeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var i = 0
        switch collectionView {
        case sourcesCollectionView:
            i = sourcesArray.count
        case countryesCollectionView:
            i = countryesArray.count
        case languagesCollectionView:
            i = languagesArray.count
        default:
            break
        }
        return i
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sourcesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourseCell", for: indexPath) as! SourcesCollectionViewCell
            cell.backgroundColor = .systemCyan
            cell.label.text = sourcesArray[indexPath.row]
            return cell
        } else if collectionView == countryesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourseCell", for: indexPath) as! SourcesCollectionViewCell
            cell.backgroundColor = .systemCyan
            cell.label.text = countryesArray[indexPath.row].rawValue
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourseCell", for: indexPath) as! SourcesCollectionViewCell
            cell.backgroundColor = .systemCyan
            cell.label.text = languagesArray[indexPath.row]
            return cell
        }
        
    }
    
    
}

extension HeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case sourcesCollectionView:
            
            let cell = collectionView.cellForItem(at: indexPath) as! SourcesCollectionViewCell
            pressCell(cell: cell)
            
        case countryesCollectionView:
            
            let cell = collectionView.cellForItem(at: indexPath) as! SourcesCollectionViewCell
            pressCell(cell: cell)
            
        case languagesCollectionView:
            
            let cell = collectionView.cellForItem(at: indexPath) as! SourcesCollectionViewCell
            pressCell(cell: cell)
            
        default:
            return
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        CGSize(width: 150, height: height/3)
    //    }
    
}

