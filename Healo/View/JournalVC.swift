//
//  JournalVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit

class JournalVC: UIViewController {

    private let navBar : UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Journal")
        let atr = [
            NSAttributedString.Key.foregroundColor: UIColor.blackPurple,
            NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 25)!
        ]
        UINavigationBar.appearance().titleTextAttributes = atr
        
        navBar.setItems([navItem], animated: false)
        navBar.barTintColor = .lightPurple
        navBar.shadowImage = UIImage()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
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
//        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Journal"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 25)!]
        navigationController?.navigationBar.tintColor = .darkPurple
    }
    
    private func setupUI() {
        view.backgroundColor = .lightPurple
        
        view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            navBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            navBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        view.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            secondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            secondView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 126),
            secondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}
