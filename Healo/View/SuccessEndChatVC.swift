//
//  SuccessEndChatVC.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 18/10/22.
//

import UIKit

class SuccessEndChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightPurple
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
        let view = ReusableLabel(labelText: "Berhasil!", type: .title)
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    private lazy var descLabel: ReusableLabel = {
        let view = ReusableLabel(labelText: "Anda telah berhasil mengakhiri obrolan.", type: .body)
        view.numberOfLines = 0
        view.textColor = .blackPurple
        view.textAlignment = .center
        return view
    }()
    
    private lazy var centerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "endchat-illus")?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var kembaliButton: ReusableNextButton = {
       let view = ReusableNextButton(text: "Berikutnya")
        view.addTarget(self, action: #selector(kembali), for: .touchUpInside)
        return view
    }()
    
    @objc func kembali() {
        // insert navigate to chat list here
        var vc: UITabBarController = SeekerTabBarVC()
        if (UserProfile.shared.userRole == 1) {
            vc = ListenerTabBarVC()
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
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
            make.top.equalToSuperview().offset(70)
            make.left.right.equalToSuperview().inset(75)
            make.height.equalTo(226)
        }
        
        whiteLabel.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(centerImage.snp.bottom).offset(56)
            make.left.right.equalToSuperview().inset(self.view.frame.height > 735 ? 145 : 120)
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
