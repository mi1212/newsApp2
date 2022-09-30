//
//  NewViewController.swift
//  newsApp
//
//  Created by Mikhail Chuparnov on 08.09.2022.
//

import UIKit
import WebKit

class NewViewController: UIViewController {
    
    var aspectRatio: CGFloat = 0.1
    
    var linkUrl: String = ""
    
    var webView: WKWebView!
    
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
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    var result : Result! {
        didSet {
            let photoUrl = result.image_url

                guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {
                    photoImageView.image = UIImage(named: "no image")
                    photoImageView.layer.opacity = 0.4
                    aspectRatio = 0.5
                    return
            }
            photoImageView.sd_setImage(with: url)
            aspectRatio = CGFloat(Float((photoImageView.image?.size.height) ?? 0.1)/Float((photoImageView.image?.size.width) ?? 1))
        }
    }

    private let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "title: "
        return label
    }()
    
    private let descriptionView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.right
        label.text = "description: "
        return label
    }()
    
    private let videoUrlView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.text = "video_url: "
        return label
    }()
    
    private let sourceIdView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.text = "source_id: "
        return label
    }()
    
    private let contentNewView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.text = "content: "
        return label
    }()
    
    private let languageView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.text = "language: "
        return label
    }()
    
    private let linkView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .natural
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(linkOpen), for: .touchUpInside)
        return button
    }()
    
    private let dateView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.layer.opacity = 0.8
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
        contentView.addSubview(titleView)
        contentView.addSubview(videoUrlView)
        contentView.addSubview(sourceIdView)
        contentView.addSubview(contentNewView)
        contentView.addSubview(linkView)
        linkView.setTitle(linkUrl, for: .normal)
        contentView.addSubview(dateView)
        
        let inset: CGFloat = 15
        
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
            contentNewView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: inset),
            contentNewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            contentNewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            videoUrlView.topAnchor.constraint(equalTo: contentNewView.bottomAnchor, constant: inset),
            videoUrlView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            videoUrlView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            linkView.topAnchor.constraint(equalTo: videoUrlView.bottomAnchor, constant: inset),
            linkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            linkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])
        
        NSLayoutConstraint.activate([
            sourceIdView.topAnchor.constraint(equalTo: linkView.bottomAnchor, constant: inset),
            sourceIdView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            sourceIdView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            sourceIdView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            sourceIdView.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: linkView.bottomAnchor, constant: inset),
            dateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            dateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            dateView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    public func setupViewController(result: Result) {
        self.result = result
        self.titleView.text! = result.title ?? " - "
        self.descriptionView.text = result.description
        self.videoUrlView.text! += result.video_url ?? " - "
        self.sourceIdView.text! += result.source_id ?? " - "
        self.contentNewView.text! = (result.content ?? result.description) ?? "-"
//        self.languageView.text! += result.language ?? " - "
        linkUrl += result.link ?? " - "

        if let date = result.pubDate {
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            formatter1.timeStyle = .short
            self.dateView.text = formatter1.string(from: date)
        }
 
    }
    
    @objc func linkOpen() {
        
        guard let url = URL(string: linkUrl) else { return }
        let webVC = WebViewController(url: url)
        self.present(webVC, animated: true)

    }

}
