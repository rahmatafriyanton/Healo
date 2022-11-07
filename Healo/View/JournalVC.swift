//
//  JournalVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit

class JournalVC: UIViewController {

    private let secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAll()
    }
    
    private func configureAll() {
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Journal"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 25)!]
        navigationController?.navigationBar.tintColor = .darkPurple
    }
    
    private func setupUI() {
        view.backgroundColor = .lightPurple
        
        view.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            secondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            secondView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 126),
            secondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}
