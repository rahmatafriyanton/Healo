//
//  HowToHealerViewController.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 06/10/22.
//

import UIKit

class HowToHealerVC: UIViewController {
    
    private lazy var titleLabel: ReusableLabel = {
        let view = ReusableLabel(labelText: "Bagaimana cara menjadi seorang Healer?", type: .title)
        view.textColor = .blackPurple
        view.textAlignment = .left
        return view
    }()
    
    private lazy var descLabel: ReusableLabel = {
        let view = ReusableLabel(labelText: "Agar dapat menjadi seorang Healer, anda harus mengambil sebuah assessment untuk menentukan apakah anda siap menjadi seorang Healer di aplikasi kami.", type: .body)
        view.textColor = .greyPurple
        view.textAlignment = .left
        return view
    }()
    
    private lazy var nextButton: ReusableNextButton = {
        let view = ReusableNextButton(text: "Berikutnya")
        view.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    @objc func tapNext() {
        // insert navigation here
        LoginVM.shared.login(myStruct: Token.self)
    }
    
    func setupConstraints(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.left.equalToSuperview().inset(38)
            make.right.equalToSuperview()
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(38)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }
    }

}
