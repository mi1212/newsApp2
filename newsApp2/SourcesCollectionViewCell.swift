//
//  SourcesCollectionViewCell.swift
//  newsApp
//
//  Created by Mikhail Chuparnov on 09.09.2022.
//

import UIKit

class SourcesCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.contentView.addSubview(label)
    
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
        ])
        self.backgroundColor = .tertiarySystemFill
        self.layer.cornerRadius = 12
    }
    
}
