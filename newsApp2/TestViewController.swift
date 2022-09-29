////
////  TestViewController.swift
////  newsApp2
////
////  Created by Mikhail Chuparnov on 29.09.2022.
////
//
//import UIKit
//
//class TestViewController: UIViewController {
//
//    let header = HeaderView(width: 10, height: 190)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .yellow
//        setup()
//    }
//    
//    private func setup() {
//        self.view.addSubview(header)
//        
//        NSLayoutConstraint.activate([
//            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            header.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            header.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            header.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//        ])
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
