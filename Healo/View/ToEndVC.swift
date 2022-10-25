//
//  ToEndVC.swift
//  Healo
//
//  Created by Elvina Jacia on 25/10/22.
//

import UIKit
import SnapKit

class ToEndVC: UIViewController {
    
    private lazy var akhiriView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFit
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(akhiriTapped))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var iconView : UIImageView = {
        let iconView = UIImageView()
        iconView.clipsToBounds = true
        iconView.image = UIImage(systemName: "minus.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .thin))
        iconView.tintColor = .blackPurple
        iconView.contentMode = .scaleAspectFit
        iconView.backgroundColor = .clear
        return iconView
    }()
    
    private lazy var akhiriLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "Akhiri Obrolan"
        return label
    }()

    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.greyPurple, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 16)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack = UIStackView()
    

    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        setupView()
        setupLayout()
    }
    
    func setupView(){
        view.backgroundColor = .blurryBack
        
        akhiriView.addSubview(iconView)
        akhiriView.addSubview(akhiriLabel)
        
        buttonStack = UIStackView(arrangedSubviews: [akhiriView, cancelButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 12
        view.addSubview(buttonStack)
    }
    
    func setupLayout(){
        setButtonLayout()
    }
    
    func setButtonLayout(){
        
        iconView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(akhiriView)
            make.left.equalTo(akhiriView.snp.left).offset(16)
        }
        
        akhiriLabel.snp.makeConstraints { make in
            make.left.equalTo(akhiriView.snp.left).offset(61)
            make.centerY.equalTo(akhiriView)
        }
        
        akhiriView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.width.equalTo(332)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.width.equalTo(332)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    @objc func akhiriTapped(){
        let evc = EndChatVC()
        evc.modalPresentationStyle = .fullScreen
        present(evc, animated: false, completion: nil)
    }
    
    @objc func cancelTapped(){
        dismiss(animated: false)
    }
}

