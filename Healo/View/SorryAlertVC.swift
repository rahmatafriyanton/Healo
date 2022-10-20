//
//  SorryAlertVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit
import SnapKit

class SorryAlertVC : UIViewController{

    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 14
        return alert
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sorry-alert")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Maaf!"
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Anda harus mengakhiri chat \nyang sedang berlangsung \nterlebih dahulu sebelum dapat \nmencari Listener baru"
        label.numberOfLines = 4
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
            make.width.equalTo(181)
            make.height.equalTo(121)
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
            make.height.equalTo(315)
            make.centerY.centerX.equalToSuperview()
        }

    }
    
    @objc func tapOkAction(){
        let svc = SeekerTabBarVC()
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: false, completion: nil)
    }
    
    
    
}
