//
//  PairingFailedVC.swift
//  Healo
//
//  Created by Hana Salsabila on 18/10/22.
//

import UIKit

class PairingFailedVC: UIViewController {

    private lazy var secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var failedImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pairing-failed")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.numberOfLines = 0
        label.text = "Pencarian Gagal"
        label.textAlignment = .center
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel : UILabel = {
       let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.numberOfLines = 0
        label.text = "Maaf, saat ini tidak ada Listener yang tersedia. Silakan coba beberapa saat lagi."
        label.textAlignment = .center
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var findNewButton : UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(onTapToPairing), for: .touchUpInside)
        button.backgroundColor = .darkPurple
        button.layer.cornerRadius = 15
        button.setTitle("Cari Listener Baru", for: .normal)
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
        let image = UIImage(systemName: "chevron.left")
        navigationItem.title = "Pairing"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsBold(size: 25)!]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(onTapBack))
        navigationItem.leftBarButtonItem?.tintColor = .darkPurple
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
        
        self.view.addSubview(failedImage)
        NSLayoutConstraint.activate([
            failedImage.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            failedImage.heightAnchor.constraint(equalToConstant: 199),
            failedImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 86),
            failedImage.widthAnchor.constraint(equalToConstant: 199)
        ])
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.topAnchor.constraint(equalTo: failedImage.bottomAnchor, constant: 24),
        ])
        
        self.view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 72),
            subtitleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 42),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -42),
        ])
        
        self.view.addSubview(findNewButton)
        NSLayoutConstraint.activate([
            findNewButton.heightAnchor.constraint(equalToConstant: 52),
            findNewButton.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 38),
            findNewButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 169),
            findNewButton.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -38),
            findNewButton.widthAnchor.constraint(equalToConstant: 314)
        ])
        
    }
    
    @objc private func onTapToPairing() {
        let cvc = CriteriaVC()
        cvc.modalPresentationStyle = .fullScreen
        present(cvc, animated: false, completion: nil)
        
    }
    
    @objc private func onTapBack() {
        let svc = SeekerTabBarVC()
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: false, completion: nil)
    }
}
