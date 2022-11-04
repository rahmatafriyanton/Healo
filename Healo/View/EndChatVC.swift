//
//  EndChatVC.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 18/10/22.
//

import UIKit

class EndChatVC: UIViewController {
    
    var cause: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightPurple
        endButton.isEnabled = false
        endButton.layer.opacity = 0.4
        setDesc()
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
    
    private lazy var warningLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var line: UIView = {
       let view = UIView()
        view.backgroundColor = .blackPurple
        return view
    }()
    
    private lazy var causeLabel: UILabel = {
       let view = UILabel()
        view.text = "Silakan pilih alasan mengapa Anda ingin mengakhiri obrolan ini"
        view.textAlignment = .center
        view.font = UIFont(name: "Poppins-Bold", size: 18.0)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var selesaiButton: ReusableChoiceButton = {
        let view = ReusableChoiceButton(text: "Obrolan sudah selesai")
        view.addTarget(self, action: #selector(selesai), for: .touchUpInside)
        return view
    }()
    
    private lazy var tidakNyamanButton: ReusableChoiceButton = {
        let view = ReusableChoiceButton(text: "Saya merasa tidak nyaman atau triggered dengan topik obrolan")
        view.addTarget(self, action: #selector(tidakNyaman), for: .touchUpInside)
        return view
    }()
    
    private lazy var lainnyaButton: ReusableChoiceButton = {
        let view = ReusableChoiceButton(text: "Lainnya")
        view.addTarget(self, action: #selector(lainnya), for: .touchUpInside)
        return view
    }()
    
    private lazy var endButton: ReusableNextButton = {
       let view = ReusableNextButton(text: "End")
        view.addTarget(self, action: #selector(end), for: .touchUpInside)
        return view
    }()
    
    private lazy var cancelButton: ReusableNextButton = {
        let view = ReusableNextButton(text: "Cancel")
        view.backgroundColor = .white
        view.setTitleColor(.darkPurple, for: .normal)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return view
    }()
    
    @objc func end(){
        print(cause)
        let sec = SuccessEndChatVC()
        sec.modalPresentationStyle = .custom
        sec.modalTransitionStyle = .crossDissolve
        present(sec, animated: false, completion: nil)
    }
    
    @objc func cancel(){
        // insert cancel
        let cvc = UINavigationController(rootViewController:ChatVC())
        cvc.isNavigationBarHidden = true
        cvc.modalPresentationStyle = .fullScreen
        cvc.modalTransitionStyle = .crossDissolve
        present(cvc, animated: false, completion: nil)
    }
    
    @objc func selesai(){
        endButton.isEnabled = true
        endButton.layer.opacity = 1
        selesaiButton.isSelected = true
        tidakNyamanButton.isSelected = false
        lainnyaButton.isSelected = false
        selesaiButton.backgroundColor = .darkPurple
        tidakNyamanButton.backgroundColor = .lightPurple
        lainnyaButton.backgroundColor = .lightPurple
        cause = "obrolan sudah selesai."
    }
    
    @objc func tidakNyaman(){
        endButton.isEnabled = true
        endButton.layer.opacity = 1
        selesaiButton.isSelected = false
        tidakNyamanButton.isSelected = true
        lainnyaButton.isSelected = false
        selesaiButton.backgroundColor = .lightPurple
        tidakNyamanButton.backgroundColor = .darkPurple
        lainnyaButton.backgroundColor = .lightPurple
        cause = "merasa tidak nyaman dengan topik obrolan Anda."
    }
    
    @objc func lainnya(){
        endButton.isEnabled = true
        endButton.layer.opacity = 1
        selesaiButton.isSelected = false
        tidakNyamanButton.isSelected = false
        lainnyaButton.isSelected = true
        selesaiButton.backgroundColor = .lightPurple
        tidakNyamanButton.backgroundColor = .lightPurple
        lainnyaButton.backgroundColor = .darkPurple
        cause = "hal lainnya."
    }
    
    func setDesc() {
        let text1 = "Anda tidak akan dapat mengobrol dengan "
        let text2 = ((UserProfile.shared.userRole == 1) ? "seeker " : "listener ")
        let text3 = "ini lagi.\n"
        let text4 = "Apa kamu yakin?"
        let attr1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 16)]
        let attr2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16)]
        let attString1 = NSMutableAttributedString(string: text1, attributes: attr2)
        let attString2 = NSMutableAttributedString(string: text2, attributes: attr1)
        let attString3 = NSMutableAttributedString(string: text3, attributes: attr2)
        let attString4 = NSMutableAttributedString(string: text4, attributes: attr1)
        attString1.append(attString2)
        attString1.append(attString3)
        attString1.append(attString4)
        warningLabel.attributedText = attString1
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
        
        whiteLabel.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height > 735 ? 64 : 30)
            make.left.right.equalToSuperview().inset(48)
        }
        
        whiteLabel.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(self.view.frame.height > 735 ? 32 : 10)
            make.left.right.equalToSuperview().inset(31)
            make.height.equalTo(1)
        }
        
        whiteLabel.addSubview(causeLabel)
        causeLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(self.view.frame.height > 735 ? 32 : 10)
            make.left.right.equalToSuperview().inset(34)
        }
        
        whiteLabel.addSubview(selesaiButton)
        selesaiButton.snp.makeConstraints { make in
            make.top.equalTo(causeLabel.snp.bottom).offset(self.view.frame.height > 735 ? 24 : 15)
            make.left.right.equalToSuperview().inset(34)
            make.height.equalTo(53)
        }
        
        whiteLabel.addSubview(tidakNyamanButton)
        tidakNyamanButton.snp.makeConstraints { make in
            make.top.equalTo(selesaiButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(34)
            make.height.equalTo(74)
        }
        
        whiteLabel.addSubview(lainnyaButton)
        lainnyaButton.snp.makeConstraints { make in
            make.top.equalTo(tidakNyamanButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(34)
            make.height.equalTo(53)
        }
        
        view.addSubview(endButton)
        endButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-31)
            make.left.equalToSuperview().offset(206)
            make.bottom.equalToSuperview().offset(self.view.frame.height > 735 ? -80 : -40)
            make.height.equalTo(52)
            
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-206)
            make.left.equalToSuperview().offset(31)
            make.bottom.equalToSuperview().offset(self.view.frame.height > 735 ? -80 : -40)
            make.height.equalTo(52)
            
        }
    }

}
