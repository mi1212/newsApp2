//
//  HeaderViewCell.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 29.09.2022.
//

import UIKit

class HeaderViewCell: UITableViewCell {

    lazy var array = [String]()
    
        private lazy var layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = CGSize(width: 2, height: self.bounds.height-6)
            return layout
        }()
    
        private lazy var collectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.delegate = self
            collection.dataSource = self
            collection.register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: "SourseCell")
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
        
    }
    
    private func setupCell() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

}

extension HeaderViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourseCell", for: indexPath) as! SourcesCollectionViewCell
//        cell.backgroundColor = .systemCyan
            cell.label.text = array[indexPath.row]
            print(indexPath)
        return cell
    }


}

extension HeaderViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 100, height: self.bounds.height-6)
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }

}


