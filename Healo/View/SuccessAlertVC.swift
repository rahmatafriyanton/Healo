//
//  SuccessAlertVC.swift
//  Healo
//
//  Created by Elvina Jacia on 09/10/22.
//

import UIKit
import SnapKit


class SuccessAlertVC : UIViewController{

    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 14
        return alert
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "congrats-illus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Selamat Datang di Healo!"
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Akun anda sudah berhasil \ndiverifikasi!"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var labelStack = UIStackView()
    
    private let stripeView: UIView = {
        let view = UIView()
        view.backgroundColor = .greyPurple
        view.alpha = 0.5
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.darkPurple, for: .normal)
        button.titleLabel?.font = .poppinsSemiBold(size: 16)
        button.addTarget(self, action: #selector(tapOkAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var okStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlertView()
        setupAlertLayout()
    }
    

    func setupAlertView(){
        view.backgroundColor = .blurryBack
        
        alertView.addSubview(imageView)
        
        labelStack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        alertView.addSubview(labelStack)

        okStack = UIStackView(arrangedSubviews: [stripeView, okButton])
        okStack.axis = .vertical
        okStack.spacing = 11
        alertView.addSubview(okStack)

        view.addSubview(alertView)
        
    }
    
    func setupAlertLayout(){
        imageView.snp.makeConstraints { make in
            make.width.equalTo(134)
            make.height.equalTo(216)
            make.top.equalTo(alertView.snp.top).offset(16)
            make.centerX.equalTo(alertView.snp.centerX)
        }
        
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(21)
            make.centerX.equalTo(alertView.snp.centerX)
        }

        stripeView.snp.makeConstraints { make in
            make.width.equalTo(alertView)
            make.height.equalTo(1)
        }

        okStack.snp.makeConstraints { make in
            make.top.equalTo(labelStack.snp.bottom).offset(9)
            make.bottom.equalTo(alertView.snp.bottom).offset(-11)
            make.centerX.equalTo(alertView)
        }

        alertView.snp.makeConstraints { make in
            make.width.equalTo(270)
            make.height.equalTo(375)
            make.centerY.centerX.equalToSuperview()
        }

    }
    
    @objc func tapOkAction(){
        
        print("Masuk ke Tabbar Seeker / Healer")
        //MARK: HABIS PENCET OK DRI ALERT
//        let tvc = TabBarController()
//        tvc.modalPresentationStyle = .fullScreen
//        present(tvc, animated: true, completion: nil)
    }
    
    
    
}
