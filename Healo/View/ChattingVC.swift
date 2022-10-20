//
//  ChattingVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit

class ChattingVC: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    let navBar : UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem()
        let backItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: nil, action: #selector(backTapped))
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        navBar.barTintColor = .white
        navBar.shadowImage = UIImage()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        setupView()
        setupLayout()
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(navBar)
    }
    
    
    func setupLayout(){
        setNavBarLayout()
    }
    
    func setNavBarLayout(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 57).isActive = true
        navBar.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc fileprivate func backTapped(){
        let svc = SeekerTabBarVC()
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: false, completion: nil)

    }
    
 }
