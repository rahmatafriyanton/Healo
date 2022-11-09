//
//  EditProfileVC.swift
//  Healo
//
//  Created by Hana Salsabila on 20/10/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol editIconImage {
    func iconClicked(selectedIconView: String)
}

class EditProfileVC: UIViewController, editIconImage {
    func iconClicked(selectedIconView: String) {
        editedIcon = selectedIconView
        print(UserProfile.shared.userProfilePict)
        print(editedIcon)
        imageUrl = editedIcon
        self.profileImage.setImage(from: editedIcon)
        self.profileImage.layer.cornerRadius = profileImage.frame.height/2
        self.profileImage.contentMode = .scaleToFill
        self.profileImage.clipsToBounds = true
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    var imageUrl = ""
    
    let disposeBag = DisposeBag()
    
    var radius : CGFloat = 0
    var selectHide : Int = 0
    
    var editedIcon : String = ""
//    var editedUsername : String = ""
//    var editedEmail : String = ""
//    var editedPassword : String = ""
    var editedGender : String = ""
    
    var tahunList = [String]()
    var selectedTahun : String = ""
    var selectTahun : Int = 0
    var tahunNow = Int(Calendar.current.component(.year, from: Date()))
    var tahunPast : Int {
        tahunNow - 50
    }
    
    var selectWoman = 0
    var selectMan = 0
    
    private lazy var profileImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightPurple
        image.frame = CGRect(x: 0, y: 0, width: 107, height: 107)
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/2
        image.setImage(from: UserProfile.shared.userProfilePict)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var editIconButton : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapEditIconBtn), for: .touchUpInside)
        btn.setTitle("Ubah Foto Profil", for: .normal)
        btn.setTitleColor(.darkPurple, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var usernameLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Username"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var usernameView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var usernameTextField : UITextField = {
        let textField = UITextField()
        let username = UserProfile.shared.username
        textField.font = .poppinsRegular(size: 14)
        textField.text = "\(username)"
        textField.textColor = .blackPurple
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private var emailLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Email"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emailTextField : UITextField = {
        let textField = UITextField()
        let email = UserProfile.shared.email
        textField.font = .poppinsRegular(size: 14)
        textField.text = "\(email)"
        textField.textColor = .blackPurple
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private var passwordLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Password"
        label.textColor = .tabBarGreyPurple
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var passwordView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var passwordTextField : UITextField = {
        let textField = UITextField()
        let password = UserProfile.shared.password
        textField.font = .poppinsRegular(size: 14)
        textField.isSecureTextEntry = true
        textField.text = "\(password)"
        textField.textColor = .blackPurple
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private lazy var hidePasswordBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapHidePassword), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btn.tintColor = .greyHide
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var jenisKelaminLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Jenis Kelamin"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var wanitaButton : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapPickWoman), for: .touchUpInside)
        btn.backgroundColor = .lightPurple
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -56, bottom: 0, right: 0)
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(systemName: "circle"), for: .normal)
        btn.setTitle("Wanita", for: .normal)
        btn.setTitleColor(.blackPurple, for: .normal)
        btn.tintColor = .tabBarGreyPurple
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        btn.titleLabel?.font = .poppinsRegular(size: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var priaButton : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapPickMan), for: .touchUpInside)
        btn.backgroundColor = .lightPurple
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -76, bottom: 0, right: 0)
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(systemName: "circle"), for: .normal)
        btn.setTitle("Pria", for: .normal)
        btn.setTitleColor(.blackPurple, for: .normal)
        btn.tintColor = .tabBarGreyPurple
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -60, bottom: 0, right: 0)
        btn.titleLabel?.font = .poppinsRegular(size: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var tahunLahirView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tahunLahirLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Tahun Lahir"
        label.textAlignment = .left
        label.textColor = .tabBarGreyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tahunLahirTextField : UITextField = {
        let textField = UITextField()
        let tahunLahir = UserProfile.shared.userYearBorn
        textField.font = .poppinsRegular(size: 14)
        textField.isSelected = false
        textField.rightViewMode = .always
        textField.text = ("\(tahunLahir)")
        textField.textAlignment = .left
        textField.textColor = .blackPurple
        textField.tintColor = .greyPurple
        textField.translatesAutoresizingMaskIntoConstraints = false
			
        
        textField.addDoneButtonOnKeyboard()
        
        return textField
    }()
    
    lazy var dropDownBtn : UIImageView = {
        let btn = UIImageView()
        btn.image = UIImage(systemName: "chevron.down")
        btn.tintColor = .greyHide
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var tahunPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = UIColor.pickerBack
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        picker.setValue(UIColor.blackPurple, forKey: "textColor")

        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAll()
    }
    
    public func configureAll() {
        setupNavBar()
        setupUI()
        selectedGender()
        tahunLahirPicker()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Edit Profil"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 18)!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(onTapSave))
        navigationItem.rightBarButtonItem!.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.poppinsMedium(size: 14)!,
            NSAttributedString.Key.foregroundColor : UIColor.darkPurple,
        ], for: .normal)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 107),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            profileImage.widthAnchor.constraint(equalToConstant: 107)
        ])
        
        view.addSubview(editIconButton)
        NSLayoutConstraint.activate([
            editIconButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            editIconButton.heightAnchor.constraint(equalToConstant: 21),
            editIconButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 9.3),
            editIconButton.widthAnchor.constraint(equalToConstant: 113)
        ])
        
        view.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.heightAnchor.constraint(equalToConstant: 21),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            usernameLabel.topAnchor.constraint(equalTo: editIconButton.bottomAnchor, constant: 24),
            usernameLabel.widthAnchor.constraint(equalToConstant: 73)
        ])
        
        view.addSubview(usernameView)
        NSLayoutConstraint.activate([
            usernameView.heightAnchor.constraint(equalToConstant: 45),
            usernameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            usernameView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            usernameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37)
        ])
        
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.centerYAnchor.constraint(equalTo: usernameView.centerYAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 21),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.heightAnchor.constraint(equalToConstant: 21),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            emailLabel.topAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: 16),
            emailLabel.widthAnchor.constraint(equalToConstant: 73)
        ])
        
        view.addSubview(emailView)
        NSLayoutConstraint.activate([
            emailView.heightAnchor.constraint(equalToConstant: 45),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            emailView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37)
        ])
        
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 21),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(passwordLabel)
        NSLayoutConstraint.activate([
            passwordLabel.heightAnchor.constraint(equalToConstant: 21),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            passwordLabel.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 16),
            passwordLabel.widthAnchor.constraint(equalToConstant: 73)
        ])
        
        view.addSubview(passwordView)
        NSLayoutConstraint.activate([
            passwordView.heightAnchor.constraint(equalToConstant: 45),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            passwordView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 21),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(hidePasswordBtn)
        NSLayoutConstraint.activate([
            hidePasswordBtn.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            hidePasswordBtn.heightAnchor.constraint(equalToConstant: 17),
            hidePasswordBtn.leadingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 14),
            hidePasswordBtn.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14),
            hidePasswordBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        view.addSubview(jenisKelaminLabel)
        NSLayoutConstraint.activate([
            jenisKelaminLabel.heightAnchor.constraint(equalToConstant: 21),
            jenisKelaminLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            jenisKelaminLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 16),
            jenisKelaminLabel.widthAnchor.constraint(equalToConstant: 99)
        ])
        
        view.addSubview(wanitaButton)
        NSLayoutConstraint.activate([
            wanitaButton.heightAnchor.constraint(equalToConstant: 45),
            wanitaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            wanitaButton.topAnchor.constraint(equalTo: jenisKelaminLabel.bottomAnchor, constant: 4),
        ])
        
        view.addSubview(priaButton)
        NSLayoutConstraint.activate([
            priaButton.heightAnchor.constraint(equalToConstant: 45),
            priaButton.leadingAnchor.constraint(equalTo: wanitaButton.trailingAnchor, constant: 7),
            priaButton.topAnchor.constraint(equalTo: jenisKelaminLabel.bottomAnchor, constant: 4),
            priaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            priaButton.widthAnchor.constraint(equalTo: wanitaButton.widthAnchor)
        ])
        
        view.addSubview(tahunLahirLabel)
        NSLayoutConstraint.activate([
            tahunLahirLabel.heightAnchor.constraint(equalToConstant: 21),
            tahunLahirLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            tahunLahirLabel.topAnchor.constraint(equalTo: wanitaButton.bottomAnchor, constant: 16),
            tahunLahirLabel.widthAnchor.constraint(equalToConstant: 83)
        ])
        
        view.addSubview(tahunLahirView)
        NSLayoutConstraint.activate([
            tahunLahirView.heightAnchor.constraint(equalToConstant: 45),
            tahunLahirView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            tahunLahirView.topAnchor.constraint(equalTo: tahunLahirLabel.bottomAnchor, constant: 4),
            tahunLahirView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37)
        ])
        
        view.addSubview(tahunLahirTextField)
        NSLayoutConstraint.activate([
            tahunLahirTextField.centerYAnchor.constraint(equalTo: tahunLahirView.centerYAnchor),
            tahunLahirTextField.heightAnchor.constraint(equalToConstant: 21),
            tahunLahirTextField.leadingAnchor.constraint(equalTo: tahunLahirView.leadingAnchor, constant: 16),
            tahunLahirTextField.trailingAnchor.constraint(equalTo: tahunLahirView.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(dropDownBtn)
        NSLayoutConstraint.activate([
            dropDownBtn.centerYAnchor.constraint(equalTo: tahunLahirView.centerYAnchor),
            dropDownBtn.heightAnchor.constraint(equalToConstant: 17),
            dropDownBtn.trailingAnchor.constraint(equalTo: tahunLahirView.trailingAnchor, constant: -16),
            dropDownBtn.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    @objc func onTapEditIconBtn(){
        let eivc = EditIconVC()
        eivc.modalPresentationStyle = .custom
        eivc.modalTransitionStyle = .crossDissolve
        eivc.delegates = self
        present(eivc, animated: false, completion: nil)
    }
    
    @objc func onTapHidePassword() {
        if selectHide == 0 {
            hidePasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            selectHide += 1
        } else if selectHide == 1 {
            hidePasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            selectHide -= 1
        }
    }
    
    private func selectedGender() {
        let gender = UserProfile.shared.userGender
        if gender == "F" {
            wanitaButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            wanitaButton.setTitleColor(.white, for: .normal)
            wanitaButton.tintColor = .white
            wanitaButton.backgroundColor = .darkPurple
            
            selectWoman = 1
            selectMan = 0
        } else if gender == "M" {
            priaButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            priaButton.setTitleColor(.white, for: .normal)
            priaButton.tintColor = .white
            priaButton.backgroundColor = .darkPurple
            
            selectWoman = 0
            selectMan = 1
        }
        editedGender = gender
    }
    
    @objc func onTapPickWoman() {
        if selectWoman == 0 {
            wanitaButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            wanitaButton.setTitleColor(.white, for: .normal)
            wanitaButton.tintColor = .white
            wanitaButton.backgroundColor = .darkPurple
            selectWoman += 1
            
            editedGender = "F"
            
            if selectMan == 1 {
                priaButton.setImage(UIImage(systemName: "circle"), for: .normal)
                priaButton.setTitleColor(.blackPurple, for: .normal)
                priaButton.tintColor = .blackPurple
                priaButton.backgroundColor = .lightPurple
                selectMan -= 1
            }
        } else {
            wanitaButton.setImage(UIImage(systemName: "circle"), for: .normal)
            wanitaButton.setTitleColor(.blackPurple, for: .normal)
            wanitaButton.tintColor = .blackPurple
            wanitaButton.backgroundColor = .lightPurple
            selectWoman -= 1
            editedGender = ""
        }
    }
    
    @objc func onTapPickMan() {
        if selectMan == 0 {
            priaButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            priaButton.setTitleColor(.white, for: .normal)
            priaButton.tintColor = .white
            priaButton.backgroundColor = .darkPurple
            selectMan += 1
            editedGender = "M"
            
            if selectWoman == 1 {
                wanitaButton.setImage(UIImage(systemName: "circle"), for: .normal)
                wanitaButton.setTitleColor(.blackPurple, for: .normal)
                wanitaButton.tintColor = .blackPurple
                wanitaButton.backgroundColor = .lightPurple
                selectWoman -= 1
            }
        } else {
            priaButton.setImage(UIImage(systemName: "circle"), for: .normal)
            priaButton.setTitleColor(.blackPurple, for: .normal)
            priaButton.tintColor = .blackPurple
            priaButton.backgroundColor = .lightPurple
            selectMan -= 1
            editedGender = ""
        }
    }
    
    func setupTahunPicker(){
        tahunList.append("Tahun Lahir")
        var tahunAdd = tahunPast
        for _ in 1...50 {
            tahunAdd += 1
            tahunList.append(String(tahunAdd))
        }
        self.selectTahun = Int(self.selectedTahun) ?? 0
    }
    
    func tahunLahirPicker() {
        tahunPickerView.delegate = self
        tahunPickerView.dataSource = self
        tahunLahirTextField.inputView = tahunPickerView
        setupTahunPicker()
    }
    
    @objc func onTapSave() {
        let editedIcon = profileImage
        guard let editedUsername = usernameTextField.text else {
            print("editedUsername empty")
            return
        }
        guard let editedEmail = emailTextField.text else {
            print("editedEmail empty")
            return
        }
        guard let editedPassword = passwordTextField.text else {
            print("editedPassword empty")
            return
        }
        guard let tahunlahir = tahunLahirTextField.text else {
            print("tahun lahir empty")
            return
        }
        guard let editedYear = Int(tahunlahir) else {
            print("editedYear empty")
            return
        }
        
        UserProfile.shared.userProfilePict = imageUrl
        UserProfile.shared.username = editedUsername
        UserProfile.shared.email = editedEmail
        UserProfile.shared.password = editedPassword
        UserProfile.shared.userGender = editedGender
        UserProfile.shared.userYearBorn = editedYear
        
        SetUserVM.shared.setUser(myStruct: [String].self)

        navigationController?.pushViewController(DataProfileVC(), animated: true)
    }
}

extension EditProfileVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tahunList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tahunList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tahunLahirTextField.text = tahunList[row]
    }
}


