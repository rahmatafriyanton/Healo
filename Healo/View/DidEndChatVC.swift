//
//  DidEndChatVC.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 17/10/22.
//

import UIKit

class DidEndChatVC: UIViewController {
    
    var cause: String = "obrolan sudah selesai"
    
    func setSeekerDesc() {
        let text1 = "Listener anda telah mengakhiri obrolan karena "
        let text2 = "\n\nAnda dapat kembali ke "
        let text3 = "halaman Chat"
        let text4 = " dan melakukan pairing dengan Listener yang baru."
        let attr1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 16)]
        let attr2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16)]
        let attString1 = NSMutableAttributedString(string: text1, attributes: attr2)
        let attStringCause = NSMutableAttributedString(string: cause, attributes: attr1)
        let attString2 = NSMutableAttributedString(string: text2, attributes: attr2)
        let attString3 = NSMutableAttributedString(string: text3, attributes: attr1)
        let attString4 = NSMutableAttributedString(string: text4, attributes: attr2)
        attString1.append(attStringCause)
        attString1.append(attString2)
        attString1.append(attString3)
        attString1.append(attString4)
        descLabel.attributedText = attString1
    }
    
    func setListenerDesc() {
        let text1 = "Seeker anda telah mengakhiri obrolan karena "
        let text2 = "\n\nAnda dapat kembali ke "
        let text3 = "halaman utama"
        let text4 = " dan menunggu hingga mendapat pairing Seeker yang baru."
        let attr1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 16)]
        let attr2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16)]
        let attString1 = NSMutableAttributedString(string: text1, attributes: attr2)
        let attStringCause = NSMutableAttributedString(string: cause, attributes: attr1)
        let attString2 = NSMutableAttributedString(string: text2, attributes: attr2)
        let attString3 = NSMutableAttributedString(string: text3, attributes: attr1)
        let attString4 = NSMutableAttributedString(string: text4, attributes: attr2)
        attString1.append(attStringCause)
        attString1.append(attString2)
        attString1.append(attString3)
        attString1.append(attString4)
        descLabel.attributedText = attString1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightPurple
        if(UserProfile.shared.userRole == 2){
            setSeekerDesc()
        } else if (UserProfile.shared.userRole == 1){
            setListenerDesc()
        } else {
            descLabel.text = "no role"
        }
        configureUI()
    }
    
    private lazy var whiteLabel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let view = UILabel()
        view.text = "End Chat"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont(name: "Poppins-SemiBold", size: 25.0)
        return view
    }()
    
    private lazy var subTitle: ReusableLabel = {
        let view = ReusableLabel(labelText: "Maaf!", type: .title)
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    private lazy var descLabel: UILabel = {
       let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .blackPurple
        view.textAlignment = .center
        return view
    }()
    
    private lazy var centerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sad-illus")?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var kembaliButton: ReusableNextButton = {
       let view = ReusableNextButton(text: "Kembali")
        view.addTarget(self, action: #selector(kembali), for: .touchUpInside)
        return view
    }()
    
    @objc func kembali() {
        // insert navigate to chat list here
    }
    
    func configureUI() {
        view.addSubview(whiteLabel)
        whiteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(126)
            make.left.right.equalToSuperview().inset(0)
            make.height.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.left.right.equalToSuperview().inset(100)
        }
        
        whiteLabel.addSubview(centerImage)
        centerImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(99)
            make.left.right.equalToSuperview().inset(84)
            make.height.equalTo(163)
        }
        
        whiteLabel.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(centerImage.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(160)
        }
        
        whiteLabel.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(41)
        }
        
        view.addSubview(kembaliButton)
        kembaliButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }
        
        
    }

}
