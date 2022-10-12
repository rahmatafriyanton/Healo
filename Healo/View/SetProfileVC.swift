//
//  SetProfileVC.swift
//  Healo
//
//  Created by Elvina Jacia on 09/10/22.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol updateIconImage {
    func iconClicked(selectedIconView: String)
}

class SetProfileVC: UIViewController, updateIconImage{
   
    func iconClicked(selectedIconView: String) {
        selectedIcon = selectedIconView

        self.iconButton.setImages(from: selectedIcon)
        self.iconButton.imageView?.layer.cornerRadius = radius
        self.iconButton.contentMode = .scaleToFill
        self.iconButton.imageView?.clipsToBounds = true
        self.iconButton.setTitle(.none, for: .normal)

        self.validateAll()
    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    var iconSize = 0
    var radius : CGFloat = 0
    
    private var viewModel = SetProfileViewModel()
    let disposeBag = DisposeBag()
   
    var selectedTahun : String = ""
    var selectTahun : Int = 0
    var selectedGender : String = ""
    var selectedIcon : String = ""

    private lazy var childView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var title1: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "Selamat datang di \nHealo!"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var body1: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .greyPurple
        label.textAlignment = .left
        label.text = "Percakapan Anda bersifat pribadi \ndan anonim. Siapkan informasi dasar \nAnda dan Anda sudah siap!"
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var labelStack = UIStackView()

    private lazy var dropDownGBtn: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 25, height: 18))
        let button = UIButton()
        let dropImage = UIImage(systemName: "chevron.down",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
        button.setImage(dropImage, for: .normal)
        button.tintColor = .greyPurple
        button.isEnabled = false
        button.sizeToFit()
        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var dropDownTBtn: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 25, height: 18))
        let button = UIButton()
        let dropImage = UIImage(systemName: "chevron.down",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
        button.setImage(dropImage, for: .normal)
        button.tintColor = .greyPurple
        button.sizeToFit()
        button.isEnabled = false
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()
    
    lazy var genderField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .lightPurple
        field.layer.cornerRadius = 10
        field.textColor = .greyPurple
        field.text = ("    "+"Jenis Kelamin")
        field.textAlignment = .left
        field.font = .poppinsRegular(size: 14)
        field.tintColor = .greyPurple
        field.rightView = dropDownGBtn
        field.rightViewMode = .always
        field.delegate = self
        
        field.inputView = genderPickerView
        field.addDoneButtonOnKeyboard()
  
        return field
    }()
    
    
    lazy var tahunLahirField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .lightPurple
        field.layer.cornerRadius = 10
        field.textColor = .greyPurple
        field.text = ("    "+"Tahun Lahir")
        field.textAlignment = .left
        field.isSelected = false
        field.font = .poppinsRegular(size: 14)
        field.tintColor = .greyPurple
        field.rightView = dropDownTBtn
        field.rightViewMode = .always
        field.delegate = self

        field.inputView = tahunPickerView
        field.addDoneButtonOnKeyboard()
        
        return field
    }()
    
    private lazy var dropListStack = UIStackView()

    
    lazy var genderPickerView : UIPickerView = {
           let picker = UIPickerView()
           picker.backgroundColor = UIColor.pickerBack
           picker.setValue(UIColor.blackPurple, forKey: "textColor")
           picker.frame = CGRect.init(x: 0.0, y: screenSize.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           picker.contentMode = .center
           picker.layer.borderColor = UIColor.pickerBorder.cgColor
           picker.layer.borderWidth = 1
           picker.tag = 1
    
           return picker
    }()

    lazy var tahunPickerView : UIPickerView = {
           let picker = UIPickerView()
           picker.backgroundColor = UIColor.pickerBack
           picker.setValue(UIColor.blackPurple, forKey: "textColor")
            picker.frame = CGRect.init(x: 0.0, y: screenSize.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           picker.contentMode = .center
           picker.tag = 2

           return picker
       }()
    
     lazy var iconButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightPurple
        button.layer.cornerRadius = radius
        button.setTitle("Pilih Icon", for: .normal)
        button.setTitleColor(.greyPurple, for: .normal)
        button.titleLabel?.font = .poppinsRegular(size: 18)
        button.tintColor = .greyPurple
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(tapIconAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var masukButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkPurple
        button.alpha = 0.4
        button.layer.cornerRadius = 10
        button.setTitle("Masuk", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 16)
        button.addTarget(self, action: #selector(tapMasukAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconSize = self.view.frame.height > 735 ? 156 : 140
        radius =  CGFloat(iconSize/2)
        configureUI()
        
        // get icons
//        LoginVM.shared.login(myStruct: Token.self)
        ProfileIconVM.shared.getIcons(myStruct: [Icon].self)
    }
    
    func configureUI(){
        setupView()
        setupLayout()
        viewModel.setupTahunPicker()
        viewModel.setupGenderPicker()
        bindPicker()
        selectedPicker()
        
        masukButton.isEnabled = false
    }
    
    
    func setupView(){
        view.backgroundColor = .white
        
        labelStack = UIStackView(arrangedSubviews: [title1, body1])
        labelStack.axis = .vertical
        labelStack.spacing = 8
        childView.addSubview(labelStack)

        
        dropListStack = UIStackView(arrangedSubviews: [genderField, tahunLahirField])
        dropListStack.axis = .horizontal
        dropListStack.spacing = 8
        childView.addSubview(dropListStack)

        childView.addSubview(iconButton)
        childView.addSubview(masukButton)
        
        view.addSubview(childView)
        
    }
    
    func setupLayout(){
        setChildViewLayout()
        setLabelLayout()
        setDroplistLayout()
        setIconLayout()
        setMasukButtonLayout()
        
    }
    
    func setChildViewLayout(){
        childView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }

    func setLabelLayout(){
        labelStack.snp.makeConstraints { make in
            make.centerX.equalTo(childView.snp.centerX)
            make.centerY.equalTo(childView.snp.centerY).offset(-205)
        }
    }

    func setDroplistLayout(){
        genderField.snp.makeConstraints { make in
            make.width.equalTo(174)
            make.height.equalTo(45)
        }

        tahunLahirField.snp.makeConstraints { make in
            make.width.equalTo(174)
            make.height.equalTo(45)
        }

        dropListStack.snp.makeConstraints { make in
            make.centerX.equalTo(childView.snp.centerX)
            make.top.equalTo(labelStack.snp.bottom).offset(24)
        }
    }

    func setIconLayout(){
        iconButton.snp.makeConstraints { make in
            make.top.equalTo(dropListStack.snp.bottom).offset(44)
            make.centerX.equalTo(childView.snp.centerX)
            make.width.equalTo(iconSize)
            make.height.equalTo(iconSize)
        }
    }
    
    func setMasukButtonLayout(){
        masukButton.snp.makeConstraints { make in
            make.centerX.equalTo(childView.snp.centerX)
            make.bottom.equalTo(childView.snp.bottom).offset(-80)
            make.width.equalTo(314)
            make.height.equalTo(52)
        }
    }
    
    func bindPicker(){
        Observable.just(viewModel.genderList)
            .bind(to: genderPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
          .disposed(by: disposeBag)
        
        Observable.just(viewModel.tahunList)
            .bind(to: tahunPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
          .disposed(by: disposeBag)
    }
    
    func selectedPicker(){
      selectedGenderPicker()
      selectedTahunPicker()
    }

    func selectedGenderPicker(){
         genderPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in

            self.selectedGender = self.viewModel.genderList[item.row]
             
    
             if(self.selectedGender == self.viewModel.genderList[0]){
                 self.selectedGender = ""
                 self.genderField.text = "    "+"Jenis Kelamin"
             } else {
                 self.genderField.text = "    " + "\(self.selectedGender)"
             }
          
            print(self.selectedGender)
             
             self.validateAll()

          }).disposed(by: disposeBag)
    }
    

    func selectedTahunPicker(){
         tahunPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in

          self.selectedTahun = self.viewModel.tahunList[item.row]
             
          if(self.selectedTahun == self.viewModel.tahunList[0]){
            self.selectedTahun = ""
            self.tahunLahirField.text =  "    " + "Tahun Lahir"
          } else {
            self.tahunLahirField.text = "    " + "\(self.selectedTahun)"
          }
          
          print(self.selectedTahun)
          self.selectTahun = Int(self.selectedTahun) ?? 0
          print(self.selectTahun)
             
          self.validateAll()
    
          }).disposed(by: disposeBag)
    }
    
    
    func validateAll(){
        if selectedGender != "" && selectedTahun != "" && selectedIcon != "" && selectTahun != 0{
            masukButton.alpha = 1
            masukButton.isEnabled = true
        } else {
            masukButton.alpha = 0.4
            masukButton.isEnabled = false
        }
    }
    

    @objc func tapIconAction(){
        let prc = PickIconVC()
        prc.modalPresentationStyle = .custom
        prc.modalTransitionStyle = .crossDissolve
        prc.delegates = self
        present(prc, animated: false, completion: nil)
    }
 
    @objc func tapMasukAction(){
        print(selectedGender.prefix(1))
        print(selectTahun)
        print(selectedIcon)
         
        //MARK: SET TO USER DEFAULT
        //UserProfile.shared.userGender(selectedGender.prefix(1))
        //UserProfile.shared.userYearBorn(selectTahun)
        //UserProfile.shared.userProfilePict()
        
        print("Berhasil MASUK")

        let avc = SuccessAlertVC()
        avc.modalPresentationStyle = .custom
        avc.modalTransitionStyle = .crossDissolve

        present(avc, animated: false, completion: nil)
        
    }
    

}
    

