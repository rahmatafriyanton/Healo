//
//  PickRoleViewController.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 04/10/22.
//

import UIKit
import SnapKit

class PickRoleVC: UIViewController {
    
    private var role: Int = 0
    
    private let seekerDesc: NSMutableAttributedString = {
        let boldText = "Seeker"
        let attr1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 16)]
        let attr2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16)]
        let attString = NSMutableAttributedString(string: boldText, attributes: attr1)
        let regText = " adalah seseorang yang membutuhkan bantuan karena kurangnya motivasi dalam melakukan self-reparenting dan membutuhkan seseorang untuk mendengarkan semua perasaan mereka."
        let regString = NSMutableAttributedString(string: regText, attributes: attr2)
        attString.append(regString)
        return attString
    }()
    
    private let healerDesc: NSMutableAttributedString = {
        let boldText = "Healer"
        let regText = " adalah seseorang yang pasti akan mendengarkan semua perasaan yang ingin dibagikan oleh Seeker dan mengingatkan mereka untuk melakukan reparenting. \n \n Untuk menjadi seorang healer Anda harus mengambil sebuah"
        let boldText2 = " assessment"
        let regText2 = " untuk menentukan kesiapan Anda."
        let attr1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 16)]
        let attr2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16)]
        let attString = NSMutableAttributedString(string: boldText, attributes: attr1)
        let regString = NSMutableAttributedString(string: regText, attributes: attr2)
        let attString2 = NSMutableAttributedString(string: boldText2, attributes: attr1)
        let regString2 = NSMutableAttributedString(string: regText2, attributes: attr2)
        attString.append(regString)
        attString.append(attString2)
        attString.append(regString2)
        return attString
    }()
    
    private lazy var roleDescLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Pilih peranmu"
        view.textColor = .blackPurple
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = UIFont(name: "Poppins-SemiBold", size: 21.0)
        return view
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Peran apa yang ingin kamu pilih dalam Healo?"
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .left
        view.font = UIFont(name: "Poppins-Regular", size: 16.0)
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

    private lazy var seekerButton: UIButton = {
       let view = UIButton()
        view.backgroundColor = .lightPurple
        view.addTarget(self, action: #selector(setSeeker), for: .touchUpInside)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var seekerImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "seeker")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .blackPurple
        return view
    }()
    
    private lazy var seekerLabel: UILabel = {
       let view = UILabel()
        view.text = "Seeker"
        view.textColor = .blackPurple
        view.font = UIFont(name: "Poppins-Regular", size: 18.0)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var seekerStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private lazy var healerButton: UIButton = {
       let view = UIButton()
        view.backgroundColor = .lightPurple
        view.addTarget(self, action: #selector(setHealer), for: .touchUpInside)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var healerImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "healer")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .blackPurple
        return view
    }()
    
    private lazy var healerLabel: UILabel = {
       let view = UILabel()
        view.text = "Healer"
        view.textColor = .blackPurple
        view.font = UIFont(name: "Poppins-Regular", size: 18.0)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var healerStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 14) ?? "", NSAttributedString.Key.foregroundColor: UIColor.darkPurple], for: .normal)
    }
    
    @objc func setSeeker() {
        role = 2
        
        seekerButton.backgroundColor = .darkPurple
        seekerImage.tintColor = .white
        seekerLabel.textColor = .white
        
        healerButton.backgroundColor = .lightPurple
        healerImage.tintColor = .blackPurple
        healerLabel.textColor = .blackPurple
        
        nextButton.isEnabled = true
        nextButton.layer.opacity = 1
        roleDescLabel.attributedText = seekerDesc
    }
    
    @objc func setHealer() {
        role = 1
        
        healerButton.backgroundColor = .darkPurple
        healerImage.tintColor = .white
        healerLabel.textColor = .white
        
        seekerButton.backgroundColor = .lightPurple
        seekerImage.tintColor = .blackPurple
        seekerLabel.textColor = .blackPurple
        
        nextButton.isEnabled = true
        nextButton.layer.opacity = 1
        roleDescLabel.attributedText = healerDesc
    }
    
    @objc func clickNext() {
        UserProfile.shared.userRole = role
        // insert navigation code here
        navigationController?.pushViewController(UserConditionsVC(), animated: true)
    }
    
    func setup(){
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.equalToSuperview().offset(128)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }
        
        view.addSubview(seekerButton)
        seekerButton.snp.makeConstraints { make in
            make.height.width.equalTo(155)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(healerButton)
        healerButton.snp.makeConstraints { make in
            make.height.width.equalTo(155)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        seekerButton.addSubview(seekerStackView)
        seekerStackView.isUserInteractionEnabled = false
        seekerStackView.isExclusiveTouch = false
        seekerStackView.addArrangedSubview(seekerImage)
        seekerStackView.addArrangedSubview(seekerLabel)
        seekerStackView.snp.makeConstraints { make in
            make.center.equalTo(seekerButton)
            make.top.bottom.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(47)
        }
        
        healerButton.addSubview(healerStackView)
        healerStackView.isUserInteractionEnabled = false
        healerStackView.isExclusiveTouch = false
        healerStackView.addArrangedSubview(healerImage)
        healerStackView.addArrangedSubview(healerLabel)
        healerStackView.snp.makeConstraints { make in
            make.center.equalTo(healerButton)
            make.top.bottom.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(47)
        }
        
        view.addSubview(roleDescLabel)
        roleDescLabel.snp.makeConstraints { make in
            make.top.equalTo(seekerButton.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(31)
        }
       
        
    }
}
