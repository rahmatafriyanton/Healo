//
//  PairingSuccessVC.swift
//  Healo
//
//  Created by Hana Salsabila on 18/10/22.
//

import UIKit

class PairingSuccessVC: UIViewController {

    let imageUrl1 = "https://images.unsplash.com/photo-1639202293330-5f8437183fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG9@by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
    
    private lazy var secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.numberOfLines = 0
        label.text = "Listener untuk Anda berhasil \n ditemukan!"
        label.textAlignment = .center
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileImage : UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 157, height: 157)
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        image.setImage(from: imageUrl1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var usernameLabel : UILabel = {
        let label = UILabel()
        let username = "johndoe"
        label.font = .poppinsSemiBold(size: 21)
        label.numberOfLines = 0
        label.text = "@\(username)"
        label.textAlignment = .center
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userLabel : UILabel = {
        let label = UILabel()
        let age = "18"
        let jk = "Pria"
        label.font = .poppinsRegular(size: 16)
        label.numberOfLines = 0
        label.text = "\(age) Tahun, \(jk)"
        label.textAlignment = .center
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reviewView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkPurple
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var reviewImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .starYellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var reviewLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.text = "4.8"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startChatButton : UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(onTapToChat), for: .touchUpInside)
        button.backgroundColor = .darkPurple
        button.layer.cornerRadius = 15
        button.setTitle("Mulai Chat", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavBar() {
        navigationItem.title = "Pairing"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsBold(size: 25)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .lightPurple
        
        setupNavBar()
        
        self.view.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            secondView.heightAnchor.constraint(equalToConstant: 718),
            secondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            secondView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 33),
            secondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 64),
            titleLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 56),
            titleLabel.widthAnchor.constraint(equalToConstant: 342)
        ])
        
        self.view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 157),
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 157)
        ])

        self.view.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30),
            usernameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            usernameLabel.widthAnchor.constraint(equalToConstant: 219)
        ])

        self.view.addSubview(userLabel)
        NSLayoutConstraint.activate([
            userLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            userLabel.heightAnchor.constraint(equalToConstant: 21),
            userLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            userLabel.widthAnchor.constraint(equalToConstant: 219)
        ])

        self.view.addSubview(reviewView)
        NSLayoutConstraint.activate([
            reviewView.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            reviewView.heightAnchor.constraint(equalToConstant: 36),
            reviewView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 12),
            reviewView.widthAnchor.constraint(equalToConstant: 72)
        ])

        self.view.addSubview(reviewImage)
        NSLayoutConstraint.activate([
            reviewImage.centerYAnchor.constraint(equalTo: reviewView.centerYAnchor),
            reviewImage.heightAnchor.constraint(equalToConstant: 18),
            reviewImage.leadingAnchor.constraint(equalTo: reviewView.leadingAnchor, constant: 10),
//            reviewImage.topAnchor.constraint(equalTo: reviewView.topAnchor, constant: 9),
            reviewImage.widthAnchor.constraint(equalToConstant: 18)
        ])

        self.view.addSubview(reviewLabel)
        NSLayoutConstraint.activate([
            reviewLabel.centerYAnchor.constraint(equalTo: reviewView.centerYAnchor),
            reviewLabel.heightAnchor.constraint(equalToConstant: 23),
            reviewLabel.leadingAnchor.constraint(equalTo: reviewImage.trailingAnchor, constant: 0),
            reviewLabel.trailingAnchor.constraint(equalTo: reviewView.trailingAnchor, constant: -6),
            reviewLabel.widthAnchor.constraint(equalToConstant: 40)
        ])

        self.view.addSubview(startChatButton)
        NSLayoutConstraint.activate([
            startChatButton.heightAnchor.constraint(equalToConstant: 52),
            startChatButton.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 38),
            startChatButton.topAnchor.constraint(equalTo: reviewView.bottomAnchor, constant: 178),
            startChatButton.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -38),
            startChatButton.widthAnchor.constraint(equalToConstant: 314)
        ])
        
    }
    
    @objc private func onTapToChat() {
        print("tap to chat")
        
        let cvc = UINavigationController(rootViewController:ChatVC(with: UserProfile.shared.currentRoomId))
        cvc.isNavigationBarHidden = true
        cvc.modalPresentationStyle = .fullScreen
        cvc.modalTransitionStyle = .crossDissolve
        present(cvc, animated: false, completion: nil)
//        navigationController?.pushViewController(ChatVC(), animated: false)
    }
}
