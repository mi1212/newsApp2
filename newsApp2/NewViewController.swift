//
//  NewViewController.swift
//  newsApp
//
//  Created by Mikhail Chuparnov on 08.09.2022.
//

import UIKit

class NewViewController: UIViewController {
    
    var aspectRatio: CGFloat = 0.1
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var result : Result! {
        didSet {
            let photoUrl = result.image_url
            
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {
                photoImageView.image = UIImage(named: "withoutImage")
                aspectRatio = 1
                return
            }
            photoImageView.sd_setImage(with: url)
            aspectRatio = CGFloat(Float((photoImageView.image?.size.height) ?? 0.1)/Float((photoImageView.image?.size.width) ?? 1))
            print(aspectRatio)
        }
    }
    
    private let nameView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name: "
        return label
    }()

    private let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = ""
        return label
    }()
    
    private let descriptionView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private let dateView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.layer.opacity = 0.8
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        self.view.backgroundColor = .white
    }
    
    private func setupViewController() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(photoImageView)
//        contentView.addSubview(nameView)
        contentView.addSubview(titleView)
        contentView.addSubview(descriptionViewLabel)
        contentView.addSubview(dateView)
//        contentView.addSubview(descriptionView)
        
        let inset: CGFloat = 5
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -inset*2),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: aspectRatio)
        ])

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: inset),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])

        NSLayoutConstraint.activate([
            descriptionViewLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: inset),
            descriptionViewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: descriptionViewLabel.bottomAnchor, constant: inset),
//            dateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            dateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            dateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }

    public func setupViewController(result: Result) {
        self.result = result
//        self.sourceView.text! = article.source.name
        self.titleView.text! = result.title ?? ""
        self.descriptionViewLabel.text = result.description
        
//        if let date = article.publishedAt {
//            let formatter1 = DateFormatter()
//            formatter1.dateStyle = .short
//            formatter1.timeStyle = .short
//            self.dateView.text = formatter1.string(from: date)
//        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
