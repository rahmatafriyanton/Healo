//
//  EditIconVC.swift
//  Healo
//
//  Created by Hana Salsabila on 20/10/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EditIconVC: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    var iconSize = 0
    var radius : CGFloat = 0
    let disposeBag = DisposeBag()
    
    var imageUrl1 = ""
    var imageUrl2 = ""
    var imageUrl3 = ""
    var imageUrl4 = ""
    var imageUrl5 = ""
    var imageUrl6 = ""
    
    var selectedImage = ""
    
    var delegates: editIconImage?
    
    private lazy var iconView : UIView = {
        let iconView = UIView()
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 15
        iconView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        iconView.backgroundColor = .white
        return iconView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 18)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Pilih Icon"
        return label
    }()
    
    private lazy var doneBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.darkPurple, for: .normal)
        button.titleLabel?.font = .poppinsRegular(size: 16)
        button.addTarget(self, action: #selector(tapDoneAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView1 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView2 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView3 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageView4 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var imageView5 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var imageView6 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var iconImage1 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapIconImage1))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    private lazy var iconImage2 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapIconImage2))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    private lazy var imageRow1 = UIStackView()
    
    private lazy var iconImage3 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapIconImage3))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    private lazy var iconImage4 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapIconImage4))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    private lazy var imageRow2 = UIStackView()
    
    private lazy var iconImage5 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapIconImage5))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    private lazy var iconImage6 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.contentMode = .scaleToFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapIconImage6))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    private lazy var imageRow3 = UIStackView()
    
    private lazy var imageVStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconSize = self.view.frame.height > 735 ? 120 : 100
        radius =  CGFloat(iconSize/2)
        configureUI()
        subscribeIcons()
    }
    
    func subscribeIcons(){
        // get icons from subject
        ProfileIconVM.shared.icons.subscribe(onNext: { event in
            self.imageUrl1 = GlobalVariable.url + event[0].image_path
            self.imageView1.setImage(from: self.imageUrl1)
            self.imageUrl2 = GlobalVariable.url + event[1].image_path
            self.imageView2.setImage(from: self.imageUrl2)
            self.imageUrl3 = GlobalVariable.url + event[2].image_path
            self.imageView3.setImage(from: self.imageUrl3)
            self.imageUrl4 = GlobalVariable.url + event[3].image_path
            self.imageView4.setImage(from: self.imageUrl4)
            self.imageUrl5 = GlobalVariable.url + event[4].image_path
            self.imageView5.setImage(from: self.imageUrl5)
            self.imageUrl6 = GlobalVariable.url + event[5].image_path
            self.imageView6.setImage(from: self.imageUrl6)
        }).disposed(by: disposeBag)
        print(imageUrl1)
    }
    

    func configureUI(){
        setupView()
        setupLayout()
    }
    
    
    func setupView(){
        view.backgroundColor = .blurryBack
        
        iconView.addSubview(titleLabel)
        iconView.addSubview(doneBtn)
        
        iconImage1.addSubview(imageView1)
        iconImage2.addSubview(imageView2)
        iconImage3.addSubview(imageView3)
        iconImage4.addSubview(imageView4)
        iconImage5.addSubview(imageView5)
        iconImage6.addSubview(imageView6)
        
        imageRow1 = UIStackView(arrangedSubviews: [iconImage1, iconImage2])
        imageRow1.axis = .horizontal
        imageRow1.spacing = 70
        imageVStack.addSubview(imageRow1)
        
        imageRow2 = UIStackView(arrangedSubviews: [iconImage3, iconImage4])
        imageRow2.axis = .horizontal
        imageRow2.spacing = 70
        imageVStack.addSubview(imageRow2)
        
        imageRow3 = UIStackView(arrangedSubviews: [iconImage5, iconImage6])
        imageRow3.axis = .horizontal
        imageRow3.spacing = 70
        imageVStack.addSubview(imageRow3)
        
        imageVStack = UIStackView(arrangedSubviews: [imageRow1, imageRow2, imageRow3])
        imageVStack.axis = .vertical
        imageVStack.spacing = self.view.frame.height > 735 ? 42 : 21
        iconView.addSubview(imageVStack)
 
        view.addSubview(iconView)
    }
    
    func setupLayout(){
        setTitleLabelLayout()
        setDoneBtnLayout()
        setImageStackLayout()
        setIconViewLayout()
    }
    
    func setIconViewLayout(){
        iconView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(self.view.frame.height > 735 ? 135 : 95)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setTitleLabelLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView).offset(25)
            make.centerX.equalTo(iconView)
        }
    }
    
    func setDoneBtnLayout(){
        doneBtn.snp.makeConstraints { make in
            make.top.equalTo(iconView).offset(20)
            make.left.equalTo(titleLabel).offset(91)
            make.right.equalTo(iconView).offset(24)
        }
    }
    
    func setImageStackLayout(){
        
        imageView1.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage1.snp.centerX)
            make.centerY.equalTo(iconImage1.snp.centerY)
            make.width.height.equalTo(iconSize)
        }
        
        iconImage1.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        
        imageView2.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage2.snp.centerX)
            make.centerY.equalTo(iconImage2.snp.centerY)
            make.width.height.equalTo(iconSize)
        }
        
        iconImage2.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        
        imageView3.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage3.snp.centerX)
            make.centerY.equalTo(iconImage3.snp.centerY)
            make.width.height.equalTo(iconSize)
        }
        
        iconImage3.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        
        imageView4.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage4.snp.centerX)
            make.centerY.equalTo(iconImage4.snp.centerY)
            make.width.height.equalTo(iconSize)
        }
        
        iconImage4.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        
        imageView5.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage5.snp.centerX)
            make.centerY.equalTo(iconImage5.snp.centerY)
            make.width.height.equalTo(iconSize)
        }
        
        iconImage5.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        
        imageView6.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage6.snp.centerX)
            make.centerY.equalTo(iconImage6.snp.centerY)
            make.width.height.equalTo(iconSize)
        }
        
        iconImage6.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        
        imageVStack.snp.makeConstraints { make in
            make.centerX.equalTo(iconView.snp.centerX)
            make.centerY.equalTo(iconView.snp.centerY).offset(self.view.frame.height > 735 ? 20 : 25)
        }
        
        
    }
    
    
    @objc func tapDoneAction(){
         delegates?.iconClicked(selectedIconView: selectedImage)
        self.dismiss(animated: true)
    }
    
    @objc func tapIconImage1(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedImage = imageUrl1
            
            iconImage1.layer.borderColor = UIColor.darkPurple.cgColor
            iconImage1.layer.borderWidth = 1
            
            iconImage2.layer.borderColor = UIColor.clear.cgColor
            iconImage2.layer.borderWidth = 0
            
            iconImage3.layer.borderColor = UIColor.clear.cgColor
            iconImage3.layer.borderWidth = 0
            
            iconImage4.layer.borderColor = UIColor.clear.cgColor
            iconImage4.layer.borderWidth = 0
            
            iconImage5.layer.borderColor = UIColor.clear.cgColor
            iconImage5.layer.borderWidth = 0
            
            iconImage6.layer.borderColor = UIColor.clear.cgColor
            iconImage6.layer.borderWidth = 0
        }
    }
    
    @objc func tapIconImage2(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedImage = imageUrl2
            
            iconImage1.layer.borderColor = UIColor.clear.cgColor
            iconImage1.layer.borderWidth = 0
            
            iconImage2.layer.borderColor = UIColor.darkPurple.cgColor
            iconImage2.layer.borderWidth = 1
            
            iconImage3.layer.borderColor = UIColor.clear.cgColor
            iconImage3.layer.borderWidth = 0
            
            iconImage4.layer.borderColor = UIColor.clear.cgColor
            iconImage4.layer.borderWidth = 0
            
            iconImage5.layer.borderColor = UIColor.clear.cgColor
            iconImage5.layer.borderWidth = 0
            
            iconImage6.layer.borderColor = UIColor.clear.cgColor
            iconImage6.layer.borderWidth = 0
        }
    }
    
    @objc func tapIconImage3(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedImage = imageUrl3
            
            iconImage1.layer.borderColor = UIColor.clear.cgColor
            iconImage1.layer.borderWidth = 0
            
            iconImage2.layer.borderColor = UIColor.clear.cgColor
            iconImage2.layer.borderWidth = 0
            
            iconImage3.layer.borderColor = UIColor.darkPurple.cgColor
            iconImage3.layer.borderWidth = 1
            
            iconImage4.layer.borderColor = UIColor.clear.cgColor
            iconImage4.layer.borderWidth = 0
            
            iconImage5.layer.borderColor = UIColor.clear.cgColor
            iconImage5.layer.borderWidth = 0
            
            iconImage6.layer.borderColor = UIColor.clear.cgColor
            iconImage6.layer.borderWidth = 0
        }
    }
    
    @objc func tapIconImage4(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedImage = imageUrl4
        
            iconImage1.layer.borderColor = UIColor.clear.cgColor
            iconImage1.layer.borderWidth = 0
            
            iconImage2.layer.borderColor = UIColor.clear.cgColor
            iconImage2.layer.borderWidth = 0
            
            iconImage3.layer.borderColor = UIColor.clear.cgColor
            iconImage3.layer.borderWidth = 0
            
            iconImage4.layer.borderColor = UIColor.darkPurple.cgColor
            iconImage4.layer.borderWidth = 1
            
            iconImage5.layer.borderColor = UIColor.clear.cgColor
            iconImage5.layer.borderWidth = 0
            
            iconImage6.layer.borderColor = UIColor.clear.cgColor
            iconImage6.layer.borderWidth = 0
         
        }
    }
    
    @objc func tapIconImage5(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedImage = imageUrl5
          
            iconImage1.layer.borderColor = UIColor.clear.cgColor
            iconImage1.layer.borderWidth = 0
            
            iconImage2.layer.borderColor = UIColor.clear.cgColor
            iconImage2.layer.borderWidth = 0
            
            iconImage3.layer.borderColor = UIColor.clear.cgColor
            iconImage3.layer.borderWidth = 0
            
            iconImage4.layer.borderColor = UIColor.clear.cgColor
            iconImage4.layer.borderWidth = 0
            
            iconImage5.layer.borderColor = UIColor.darkPurple.cgColor
            iconImage5.layer.borderWidth = 1
            
            iconImage6.layer.borderColor = UIColor.clear.cgColor
            iconImage6.layer.borderWidth = 0
            
        }
    }
    
    @objc func tapIconImage6(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedImage = imageUrl6
      
            iconImage1.layer.borderColor = UIColor.clear.cgColor
            iconImage1.layer.borderWidth = 0
            
            iconImage2.layer.borderColor = UIColor.clear.cgColor
            iconImage2.layer.borderWidth = 0
            
            iconImage3.layer.borderColor = UIColor.clear.cgColor
            iconImage3.layer.borderWidth = 0
            
            iconImage4.layer.borderColor = UIColor.clear.cgColor
            iconImage4.layer.borderWidth = 0
            
            iconImage5.layer.borderColor = UIColor.clear.cgColor
            iconImage5.layer.borderWidth = 0
            
            iconImage6.layer.borderColor = UIColor.darkPurple.cgColor
            iconImage6.layer.borderWidth = 1
            
        }
    }
    
    
}

