//
//  VerifyFailedVC.swift
//  Healo
//
//  Created by Hana Salsabila on 16/11/22.
//

import UIKit

class VerifyFailedVC: UIViewController {

    private let secondView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sad-illus")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.numberOfLines = 0
        label.text = "Verifikasi Gagal"
        label.textAlignment = .center
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.numberOfLines = 0
        label.text = "Maaf, kode OTP yang anda masukkan \nsalah."
        label.textAlignment = .center
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tryAgainButton : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapTryAgain), for: .touchUpInside)
        btn.backgroundColor = .darkPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("Coba Lagi", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
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
        setupConstraints()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(secondView)
        secondView.addSubview(imageView)
        secondView.addSubview(titleLabel)
        secondView.addSubview(detailLabel)
        view.addSubview(tryAgainButton)
    }
    
    private func setupConstraints() {
        setupSecondView()
        setupImageView()
        setupTitleLabel()
        setupDetailLabel()
        setupTryAgainButton()
    }
    
    private func setupSecondView() {
        NSLayoutConstraint.activate([
            secondView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 307),
            secondView.widthAnchor.constraint(equalToConstant: 306)
        ])
    }
    
    private func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: secondView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 183),
            imageView.widthAnchor.constraint(equalToConstant: 199)
        ])
    }
    
    private func setupTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 36),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.widthAnchor.constraint(equalToConstant: 306)
        ])
    }
    
    private func setupDetailLabel() {
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            detailLabel.heightAnchor.constraint(equalToConstant: 48),
            detailLabel.widthAnchor.constraint(equalToConstant: 306)
        ])
    }
    
    private func setupTryAgainButton() {
        NSLayoutConstraint.activate([
            tryAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -79),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 52),
            tryAgainButton.widthAnchor.constraint(equalToConstant: 314)
        ])
    }
    
    @objc private func onTapTryAgain() {
        self.dismiss(animated: true)
    }
}
