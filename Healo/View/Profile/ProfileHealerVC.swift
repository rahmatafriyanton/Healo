//
//  ProfileHealerVC.swift
//  Healo
//
//  Created by Hana Salsabila on 20/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileHealerVC: UIViewController {
    
    let imageUrl = UserProfile.shared.userProfilePict
    var gender : String = ""
    var age : Int = 0
    
    var dataProfils: [DataProfil] = []
    var availableStatus : Int = 0
    
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
    
    private var usernameLabel : UILabel = {
        let label = UILabel()
        let username = UserProfile.shared.username
        label.font = .poppinsSemiBold(size: 21)
        label.text = "@\(username)"
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ageGenderLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .greyPurple
        label.textAlignment = .left
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
    
    private var reviewImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .starYellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var reviewLabel : UILabel = {
        let label = UILabel()
        let rate = "4.8"
        label.font = .poppinsRegular(size: 16)
        label.text = "\(rate)"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var statusLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 14)
        label.text = "Status"
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var availableLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.text = "Available"
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var availableSwitch : UISwitch = {
        let swh = UISwitch()
        swh.addTarget(self, action: #selector(onTapSwitch), for: .valueChanged)
        swh.translatesAutoresizingMaskIntoConstraints = false
        return swh
    }()
    
    private var dataPribadiLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 14)
        label.text = "Data Pribadi"
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dataPribadiTV : UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .none
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var logOutButton : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapLogout), for: .touchUpInside)
        btn.backgroundColor = .darkPurple
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        btn.layer.cornerRadius = 15
        btn.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        btn.setTitle("Keluar", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 16)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
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
        setupTableView()
        ageGenderDetail()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Profil"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 25)!]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .darkPurple
    }
    
    private func setupUI() {
        view.backgroundColor = .lightPurple
        
        view.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            secondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            secondView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            secondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 111),
            profileImage.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 40),
            profileImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 36),
            profileImage.widthAnchor.constraint(equalToConstant: 111)
        ])
        
        view.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.heightAnchor.constraint(equalToConstant: 29),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 22.3),
            usernameLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 36),
            usernameLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: 43)
        ])
        
        view.addSubview(ageGenderLabel)
        NSLayoutConstraint.activate([
            ageGenderLabel.heightAnchor.constraint(equalToConstant: 22),
            ageGenderLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 22.3),
            ageGenderLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            ageGenderLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: 43)
        ])
        
        view.addSubview(reviewView)
        NSLayoutConstraint.activate([
            reviewView.heightAnchor.constraint(equalToConstant: 35),
            reviewView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 22.3),
            reviewView.topAnchor.constraint(equalTo: ageGenderLabel.bottomAnchor, constant: 12),
            reviewView.widthAnchor.constraint(equalToConstant: 63)
        ])
        
        view.addSubview(reviewImage)
        NSLayoutConstraint.activate([
            reviewImage.centerYAnchor.constraint(equalTo: reviewView.centerYAnchor),
            reviewImage.heightAnchor.constraint(equalToConstant: 18),
            reviewImage.leadingAnchor.constraint(equalTo: reviewView.leadingAnchor, constant: 10),
            reviewImage.widthAnchor.constraint(equalToConstant: 18)
        ])

        view.addSubview(reviewLabel)
        NSLayoutConstraint.activate([
            reviewLabel.centerYAnchor.constraint(equalTo: reviewView.centerYAnchor),
            reviewLabel.heightAnchor.constraint(equalToConstant: 23),
            reviewLabel.leadingAnchor.constraint(equalTo: reviewImage.trailingAnchor, constant: 0),
            reviewLabel.trailingAnchor.constraint(equalTo: reviewView.trailingAnchor, constant: -6),
            reviewLabel.widthAnchor.constraint(equalToConstant: 40)
        ])

        view.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 21),
            statusLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 40),
            statusLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 33.3),
//            statusLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -54),
            statusLabel.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        view.addSubview(availableLabel)
        NSLayoutConstraint.activate([
            availableLabel.heightAnchor.constraint(equalToConstant: 28),
            availableLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 40),
            availableLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 14),
            availableLabel.widthAnchor.constraint(equalToConstant: 95)
        ])
        
        view.addSubview(availableSwitch)
        NSLayoutConstraint.activate([
            availableSwitch.heightAnchor.constraint(equalToConstant: 31),
            availableSwitch.centerYAnchor.constraint(equalTo: availableLabel.centerYAnchor),
            availableSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            availableSwitch.widthAnchor.constraint(equalToConstant: 51)
        ])
        
        view.addSubview(dataPribadiLabel)
        NSLayoutConstraint.activate([
            dataPribadiLabel.heightAnchor.constraint(equalToConstant: 28),
            dataPribadiLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 40),
            dataPribadiLabel.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: 30),
            dataPribadiLabel.widthAnchor.constraint(equalToConstant: 95)
        ])
        
        view.addSubview(dataPribadiTV)
        NSLayoutConstraint.activate([
            dataPribadiTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            dataPribadiTV.heightAnchor.constraint(equalToConstant: 205),
            dataPribadiTV.topAnchor.constraint(equalTo: dataPribadiLabel.bottomAnchor, constant: 0),
            dataPribadiTV.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(logOutButton)
        NSLayoutConstraint.activate([
            logOutButton.heightAnchor.constraint(equalToConstant: 52),
            logOutButton.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 38),
            logOutButton.topAnchor.constraint(equalTo: dataPribadiTV.bottomAnchor, constant: 47.5),
            logOutButton.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -38)
        ])
    }
    
    private func ageGenderDetail() {
        let getAge = UserProfile.shared.userYearBorn
        let getGender = UserProfile.shared.userGender
        let year = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year
        
        age = year! - getAge
        
        if getGender == "F" {
            gender = "Wanita"
        } else if getGender == "M" {
            gender = "Pria"
        }
        ageGenderLabel.text = "\(age) Tahun, \(gender)"
    }
    
    @objc func onTapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            availableStatus = 1
        } else {
            availableStatus = 0
        }
        UserProfile.shared.userIsAvailable = availableStatus
    }
    
    private func setupTableView() {
        dataPribadiTV.dataSource = self
        dataPribadiTV.delegate = self
        dataPribadiTV.frame = view.bounds
        dataProfils = fetchData()
    }
    
    func fetchData() -> [DataProfil] {
        let dataProfil1 = DataProfil(image: "person.circle.fill", title: "Data Profil")
        let dataProfil2 = DataProfil(image: "doc.plaintext", title: "Sertifikat")
        let dataProfil3 = DataProfil(image: "star.fill", title: "Ulasan")
        
        return [dataProfil1, dataProfil2, dataProfil3]
    }
    
    @objc func onTapLogout() {
        UserProfile.shared.token = ""
        let lvc = LoginVC()
        lvc.modalPresentationStyle = .fullScreen
        present(lvc, animated: false, completion: nil)
    }
}

extension ProfileHealerVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProfils.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell
        
        cell?.configure(image: dataProfils[indexPath.row].image, text: dataProfils[indexPath.row].title)
        cell?.selectionStyle = .none
        cell?.tintColor = .darkPurple
        
        if (indexPath.row == 2) {
            cell!.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = DataProfileVC()
            vc.title = "Data Profil)"
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = SertifikatDetailVC()
            vc.title = "Sertifikat"
            navigationController?.pushViewController(vc, animated: true)
        } else {
//            let vc = ReviewVC()
//            vc.title = "Ulasan"
//            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.5
    }
}

struct DataProfil {
    let image : String
    let title : String
}


