//
//  DataProfileVC.swift
//  Healo
//
//  Created by Hana Salsabila on 20/10/22.
//

import UIKit

class DataProfileVC: UIViewController {
    
    var imageUrl = UserProfile.shared.userProfilePict
    
    private let secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightPurple
        image.frame = CGRect(x: 0, y: 0, width: 111, height: 111)
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/2
        image.setImage(from: imageUrl)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var editButton : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapEditProfile), for: .touchUpInside)
        btn.backgroundColor = .darkPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("Edit Profil", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 12)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var usernameLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Username"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var usernameDetailLabel : UILabel = {
        let label = UILabel()
        let username = UserProfile.shared.username
        label.font = .poppinsMedium(size: 14)
        label.text = "@\(username)"
        label.textAlignment = .left
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Email"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailDetailLabel: UILabel = {
        let label = UILabel()
        let email = UserProfile.shared.email
        label.font = .poppinsMedium(size: 14)
        label.numberOfLines = 0
        label.text = "\(email)"
        label.textAlignment = .left
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var jenisKelaminLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Jenis Kelamin"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var jkDetailLabel : UILabel = {
        let label = UILabel()
        let jenisKelamin = UserProfile.shared.userGender
        var gender = ""
        if jenisKelamin == "F" {
            gender = "Wanita"
        } else if jenisKelamin == "M" {
            gender = "Pria"
        }
        
        label.font = .poppinsMedium(size: 14)
        label.text = "\(gender)"
        label.textAlignment = .left
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tahunLahirLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Tahun Lahir"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tahunLahirDetailLabel : UILabel = {
        let label = UILabel()
        let tahunLahir = UserProfile.shared.userYearBorn
        label.font = .poppinsMedium(size: 14)
        label.text = "\(tahunLahir)"
        label.textAlignment = .left
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var logOutButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .darkPurple
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        btn.layer.cornerRadius = 15
        btn.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        btn.setTitle("Keluar", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 16)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(onTapLogout), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAll()
    }
    
    private func configureAll() {
        setupNavBar()
        setupUI()
        hideLogOutBtn()
    }
    
    private func setupNavBar() {
        if UserProfile.shared.userRole == 1 {
            navigationItem.title = "Data Profil"
        } else {
            navigationItem.title = "Profil"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 25)!]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 111),
            profileImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 36),
            profileImage.widthAnchor.constraint(equalToConstant: 111)
        ])
        
        view.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 33),
            editButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 9),
            editButton.widthAnchor.constraint(equalToConstant: 82)
        ])
        
        view.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.heightAnchor.constraint(equalToConstant: 21),
            usernameLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 56),
            usernameLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 209),
            usernameLabel.widthAnchor.constraint(equalToConstant: 99)
        ])
        
        view.addSubview(usernameDetailLabel)
        NSLayoutConstraint.activate([
            usernameDetailLabel.heightAnchor.constraint(equalToConstant: 21),
            usernameDetailLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 33),
            usernameDetailLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 209),
            usernameDetailLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -54),
            usernameDetailLabel.widthAnchor.constraint(equalToConstant: 99)
        ])
        
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.heightAnchor.constraint(equalToConstant: 21),
            emailLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 56),
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 24),
            emailLabel.widthAnchor.constraint(equalToConstant: 99)
        ])
        
        view.addSubview(emailDetailLabel)
        NSLayoutConstraint.activate([
            emailDetailLabel.heightAnchor.constraint(equalToConstant: 21),
            emailDetailLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 33),
            emailDetailLabel.topAnchor.constraint(equalTo: usernameDetailLabel.bottomAnchor, constant: 24),
            emailDetailLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),
        ])
        
        view.addSubview(jenisKelaminLabel)
        NSLayoutConstraint.activate([
            jenisKelaminLabel.heightAnchor.constraint(equalToConstant: 21),
            jenisKelaminLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 56),
            jenisKelaminLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24),
            jenisKelaminLabel.widthAnchor.constraint(equalToConstant: 99)
        ])
        
        view.addSubview(jkDetailLabel)
        NSLayoutConstraint.activate([
            jkDetailLabel.heightAnchor.constraint(equalToConstant: 21),
            jkDetailLabel.leadingAnchor.constraint(equalTo: jenisKelaminLabel.trailingAnchor, constant: 33),
            jkDetailLabel.topAnchor.constraint(equalTo: emailDetailLabel.bottomAnchor, constant: 24),
            jkDetailLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -54),
        ])
        
        view.addSubview(tahunLahirLabel)
        NSLayoutConstraint.activate([
            tahunLahirLabel.heightAnchor.constraint(equalToConstant: 21),
            tahunLahirLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 56),
            tahunLahirLabel.topAnchor.constraint(equalTo: jenisKelaminLabel.bottomAnchor, constant: 24),
            tahunLahirLabel.widthAnchor.constraint(equalToConstant: 99)
        ])
        
        view.addSubview(tahunLahirDetailLabel)
        NSLayoutConstraint.activate([
            tahunLahirDetailLabel.heightAnchor.constraint(equalToConstant: 21),
            tahunLahirDetailLabel.leadingAnchor.constraint(equalTo: tahunLahirLabel.trailingAnchor, constant: 33),
            tahunLahirDetailLabel.topAnchor.constraint(equalTo: jkDetailLabel.bottomAnchor, constant: 24),
            tahunLahirDetailLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -54),
        ])
        
        view.addSubview(logOutButton)
        NSLayoutConstraint.activate([
            logOutButton.heightAnchor.constraint(equalToConstant: 52),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            logOutButton.topAnchor.constraint(equalTo: tahunLahirDetailLabel.bottomAnchor, constant: 164),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38)
        ])
    }
    
    private func hideLogOutBtn() {
        if UserProfile.shared.userRole == 1 {
            logOutButton.isHidden = true
        } else {
            logOutButton.isHidden = false
        }
    }
    
    @objc func onTapEditProfile() {
        navigationController?.pushViewController(EditProfileVC(), animated: true)
    }

    @objc func onTapLogout() {
        UserProfile.shared.token = ""
        print("token pas logout:")
        print(UserProfile.shared.token)
        let lvc = UINavigationController(rootViewController: LoginVC())
        lvc.modalPresentationStyle = .fullScreen
        lvc.modalTransitionStyle = .crossDissolve
        present(lvc, animated: false, completion: nil)
    }
}
