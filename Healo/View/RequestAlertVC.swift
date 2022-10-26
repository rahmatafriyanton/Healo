//
//  RequestAlertVC.swift
//  Healo
//
//  Created by Elvina Jacia on 26/10/22.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RequestAlertVC : UIViewController{
    public let preflek: String = ""
    private var pair: Pair = Pair(id: "", seeker_id: 0, healer_id: 0, status: "", min_age: 0, max_age: 0, prefered_gender: "", seeker_preflection: "no pref")
    private var bag = DisposeBag()

    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 15
        alert.contentMode = .scaleAspectFit
        return alert
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "newseeker-popup-illus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Seseorang ingin didengar!"
        return label
    }()
    
    private lazy var topikLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 14)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.text = "Topic Pembicaraan"
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.numberOfLines = 0
        label.contentMode = .scaleAspectFit
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let topikView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.blackPurple.cgColor
        view.layer.borderWidth = 1
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var topikStack = UIStackView()
    
    private let stripeView: UIView = {
        let view = UIView()
        view.backgroundColor = .greyPurple
        view.alpha = 0.5
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var tolakButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tolak", for: .normal)
        button.setTitleColor(.blackPurple, for: .normal)
        button.titleLabel?.font = .poppinsRegular(size: 16)
        button.addTarget(self, action: #selector(tapTolakAction), for: .touchUpInside)
        return button
    }()
    
    private let vstripeView: UIView = {
        let view = UIView()
        view.backgroundColor = .greyPurple
        view.alpha = 0.5
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var terimaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terima", for: .normal)
        button.setTitleColor(.darkPurple, for: .normal)
        button.titleLabel?.font = .poppinsSemiBold(size: 16)
        button.addTarget(self, action: #selector(tapTerimaAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack = UIStackView()
    private lazy var stripeBtnStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketHandler.shared.pairInfo.subscribe(onNext: { [self] event in
            pair = event
            setupData()
        }).disposed(by: bag)
        setupData()
        setupAlertView()
        setupAlertLayout()
    }
    
    func setupData(){
//        messageLabel.text = "Aku pengen share tentang gimana perasaanku hari ini."
        messageLabel.text = pair.seeker_preflection

    }
    
    func setupAlertView(){
        view.backgroundColor = .blurryBack
        
        alertView.addSubview(titleLabel)
        alertView.addSubview(imageView)
        
        topikStack = UIStackView(arrangedSubviews: [topikLabel, messageLabel])
        topikStack.axis = .vertical
        topikStack.spacing = 8
        topikView.addSubview(topikStack)
        
        alertView.addSubview(topikView)
        
        stripeBtnStack = UIStackView(arrangedSubviews: [tolakButton, vstripeView, terimaButton])
        stripeBtnStack.axis = .horizontal
        stripeBtnStack.spacing = 39
        alertView.addSubview(stripeBtnStack)

        buttonStack = UIStackView(arrangedSubviews: [stripeView, stripeBtnStack])
        buttonStack.axis = .vertical
        buttonStack.spacing = 0
        alertView.addSubview(buttonStack)

        view.addSubview(alertView)
    }
    
    func setupAlertLayout(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView.snp.top).offset(32)
            make.centerX.equalTo(alertView.snp.centerX)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(116)
            make.height.equalTo(122)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalTo(alertView.snp.centerX)
        }
        
        topikStack.snp.makeConstraints { make in
            make.top.equalTo(topikView.snp.top).offset(15)
            make.centerX.equalTo(topikView.snp.centerX)
            make.bottom.equalTo(topikView.snp.bottom).offset(-15)
            make.left.equalTo(topikView.snp.left).offset(12)
            make.right.equalTo(topikView.snp.right).offset(-12)
        }
        
        topikView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalTo(alertView.snp.centerX)
            make.height.equalTo(topikStack.snp.height).offset(20)
            make.width.equalTo(233)
        }
        
        stripeView.snp.makeConstraints { make in
            make.width.equalTo(alertView)
            make.height.equalTo(1)
            make.centerX.equalTo(alertView)
        }
        
        vstripeView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        
        stripeBtnStack.snp.makeConstraints { make in
            make.centerX.equalTo(alertView)
            make.left.equalTo(alertView.snp.left).offset(42)
            make.right.equalTo(alertView.snp.right).offset(-42)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(topikView.snp.bottom).offset(24)
            make.bottom.equalTo(alertView.snp.bottom)
        }
        
        alertView.snp.makeConstraints { make in
            make.width.equalTo(270)
            make.height.equalTo(395)
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    @objc func tapTolakAction(){
        self.dismiss(animated: false)
    }
    
    @objc func tapTerimaAction(){
        //MARK: Ke chat vc sesuai seeker idnya
        print("Masuk ke halaman chat")
        pair.status = "accept"
        SocketHandler.shared.mSocket.emit("confirm_pairing",pair)
        self.dismiss(animated: false)
//        navigationController?.pushViewController(ChatVC(), animated: true)
    }
    
    
    
}


