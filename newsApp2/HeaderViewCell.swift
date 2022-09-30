//
//  HeaderViewCell.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 29.09.2022.
//

import UIKit

protocol HeaderViewCellDelegate: AnyObject {
    func chooseParam(section: Int, row: Int)
}

class HeaderViewCell: UITableViewCell {
     
    weak var delegate: HeaderViewCellDelegate?
    
    var section = 0

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
            collection.backgroundColor = .clear
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
        self.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func pressCell(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

}

extension HeaderViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourseCell", for: indexPath) as! SourcesCollectionViewCell
        cell.label.text = "\(array[indexPath.row])"
        return cell
    }


}

extension HeaderViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let cell = collectionView.cellForItem(at: indexPath) as! SourcesCollectionViewCell
        pressCell(cell: cell)
        
        delegate?.chooseParam(section: section, row: indexPath.row)
        
        
    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 100, height: self.bounds.height-6)
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }

}


