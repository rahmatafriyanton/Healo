//
//  UserConditionsViewController.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 04/10/22.
//

import UIKit
//import RxSwift
//import RxCocoa

class UserConditionsVC: UIViewController {
    var accepted: Int = 0
    var agreementTime: String = "no time"
    let dateFormatter = DateFormatter()
        
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Aplikasi ini bukan untuk Anda jika Anda..."
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .left
        view.font = UIFont(name: "Poppins-SemiBold", size: 21.0)
        return view
    }()
    
    private lazy var descLabel: UILabel = {
       let view = UILabel()
        view.text = "• Memiliki kecenderungan bunuh diri \n" +
                    "• Seseorang penderita depresi \n" +
                    "• Memiliki kecenderungan untuk \n   menyakiti atau membunuh \n" +
        "• Memiliki kecenderungan untuk \n   melecehkan seseorang"
        view.font = UIFont(name: "Poppins-Regular", size: 16.0)
        view.textColor = .greyPurple
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var checkBoxLabel: UILabel = {
        let view = UILabel()
        view.text = "Dengan mencentang ini, saya setuju bahwa saya tidak memiliki kondisi yang disebutkan di atas"
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .left
        view.font = UIFont(name: "Poppins-Regular", size: 16.0)
        return view
    }()
    
    private lazy var checkBox: UIButton = {
       let view = UIButton()
        let normalImage = UIImage(systemName: "square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))?.withTintColor(.darkPurple, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))?.withTintColor(.darkPurple, renderingMode: .alwaysOriginal)
        view.setImage(normalImage, for: .normal)
        view.setImage(selectedImage, for: .selected)
//        view.backgroundColor = .red
//        view.frame = CGRect(x: 0, y: 0 , width: 80, height: 80)
//        view.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.imageView?.contentMode = .scaleToFill
        view.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
       let view = UIButton()
        view.isEnabled = false
        view.setTitle("Berikutnya", for: .normal)
        view.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        view.addTarget(self, action: #selector(clickNext), for: .touchUpInside)
        view.backgroundColor = .darkPurple
        view.layer.cornerRadius = 15
        view.layer.opacity = 0.4
        return view
    }()
    
    @objc func toggleCheck() {
        if(checkBox.isSelected) {
            checkBox.isSelected = false
            accepted = 0
            nextButton.isEnabled = false
            nextButton.layer.opacity = 0.4
        } else {
            checkBox.isSelected = true
            accepted = 1
            nextButton.isEnabled = true
            nextButton.layer.opacity = 1
            let dateNow = Date()
            agreementTime = dateFormatter.string(from: dateNow)
        }
    }
    
    @objc func clickNext() {
        UserProfile.shared.agreementTime = agreementTime
        UserProfile.shared.isAcceptAgreement = accepted

        // insert navigation code here
        navigationController?.pushViewController(RegisterVC(), animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        setupConstraints()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 14) ?? "", NSAttributedString.Key.foregroundColor: UIColor.darkPurple], for: .normal)
        
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.left.right.equalToSuperview().inset(38)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38)
            make.right.equalToSuperview().offset(-29)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        view.addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38)
            make.bottom.equalToSuperview().offset(-214)
            make.height.width.equalTo(24)
        }
        
        view.addSubview(checkBoxLabel)
        checkBoxLabel.snp.makeConstraints { make in
            make.left.equalTo(checkBox.snp.right).offset(16)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(checkBox.snp.top)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }
    }



}
