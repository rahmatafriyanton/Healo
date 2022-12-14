//
//  OnboardingViewController.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 06/10/22.
//

import UIKit

class OnboardingVC: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Selamat Datang di Healo!"
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont(name: "Poppins-SemiBold", size: 21.0)
        return view
    }()
    
    private lazy var centerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chat-illus")?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var descLabel: UILabel = {
       let view = UILabel()
        view.text = "Berbicara dengan seorang Healer untuk dukungan emosional."
        view.font = UIFont(name: "Poppins-Medium", size: 16.0)
        view.textColor = .greyPurple
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var registerButton: ReusableNextButton = {
        let view = ReusableNextButton(text: "Buat Akun Baru")
        view.addTarget(self, action: #selector(tapRegister), for: .touchUpInside)
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let view = UIButton()
        let attributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16.0)!, NSAttributedString.Key.foregroundColor: UIColor.blackPurple]
        let attributedString = NSAttributedString(string: "Saya sudah punya akun", attributes: attributes)
        view.setAttributedTitle(attributedString, for: .normal)
        view.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        return view
    }()
    
    var imgSize = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .darkPurple
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 14) ?? "", NSAttributedString.Key.foregroundColor: UIColor.darkPurple], for: .normal)
        imgSize = self.view.frame.height > 735 ? 281 : 210
        setupConfiguration()
    }
    
    @objc func tapRegister(){
        navigationController?.pushViewController(PickRoleVC(), animated: true)
    }
    
    @objc func tapLogin(){
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    func setupConfiguration() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.left.right.equalToSuperview().inset(50)
        }
        
        view.addSubview(centerImage)
        centerImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.left.right.equalToSuperview().inset(55)
            make.height.equalTo(imgSize)
            make.width.equalTo(imgSize)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(centerImage.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(36)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
           // make.left.right.equalToSuperview().inset(96)
            make.centerX.equalTo(registerButton)
            make.bottom.equalToSuperview().offset(-38)
        }
    }

}
