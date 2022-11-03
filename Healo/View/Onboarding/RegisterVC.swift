//
//  RegisterVC.swift
//  Healo
//
//  Created by Hana Salsabila on 09/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterVC : UIViewController {
    
    private var statusRegisterVC : String = ""
    private var bag = DisposeBag()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.text = "Buat Akun"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(usernameChanged), for: .editingChanged)
        textField.font = .poppinsRegular(size: 14)
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 10
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private lazy var usernameError : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.text = "Masukkan username Anda"
        label.textColor = .redError
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        textField.font = .poppinsRegular(size: 14)
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 10
        textField.placeholder = "Email Address"
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private lazy var emailError : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.textColor = .redError
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        textField.font = .poppinsRegular(size: 14)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private lazy var passwordError : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.textColor = .redError
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hidePasswordBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapHidePassword), for: .touchUpInside)
        btn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btn.tintColor = .greyHide
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let confirmPasswordView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confirmPasswordTextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(confirmPasswordChanged), for: .editingChanged)
        textField.font = .poppinsRegular(size: 14)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "Confirm Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
			textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private lazy var confirmPasswordError : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.textColor = .redError
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hideConfirmPasswordBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapHideConfirmPassword), for: .touchUpInside)
        btn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btn.tintColor = .greyHide
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tncLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        btn.backgroundColor = .lightGreyPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("Daftar", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var toLoginLabel : UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confidentialLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Informasi Anda 100% rahasia dan tidak pernah dibagikan dengan siapa pun"
        label.textColor = .greyPurple
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var select = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17) ?? "",NSAttributedString.Key.foregroundColor : UIColor.darkPurple], for: .normal)
    }
    
    private func setupUI() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupNavBar()
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        self.view.addSubview(usernameView)
        NSLayoutConstraint.activate([
            usernameView.heightAnchor.constraint(equalToConstant: 45),
            usernameView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            usernameView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            usernameView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -36),
        ])
        
        self.view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: 45),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor, constant: 14),
            usernameTextField.topAnchor.constraint(equalTo: usernameView.topAnchor, constant: 0),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor, constant: -14)
        ])
        
        self.view.addSubview(usernameError)
        NSLayoutConstraint.activate([
            usernameError.heightAnchor.constraint(equalToConstant: 24),
            usernameError.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            usernameError.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 0)
        ])
        
        self.view.addSubview(emailView)
        NSLayoutConstraint.activate([
            emailView.heightAnchor.constraint(equalToConstant: 45),
            emailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            emailView.topAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: 36),
            emailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -36)
        ])
        
        self.view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.leadingAnchor.constraint(equalTo: emailView
                .leadingAnchor, constant: 14),
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 0),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -14)
        ])
        
        self.view.addSubview(emailError)
        NSLayoutConstraint.activate([
            emailError.heightAnchor.constraint(equalToConstant: 24),
            emailError.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            emailError.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0)
        ])
        
        self.view.addSubview(passwordView)
        NSLayoutConstraint.activate([
            passwordView.heightAnchor.constraint(equalToConstant: 45),
            passwordView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            passwordView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 36),
            passwordView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -36)
        ])
        
        self.view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 14),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 0),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14)
        ])
        
        self.view.addSubview(passwordError)
        NSLayoutConstraint.activate([
            passwordError.heightAnchor.constraint(equalToConstant: 24),
            passwordError.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            passwordError.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0)
        ])
        
        self.view.addSubview(hidePasswordBtn)
        NSLayoutConstraint.activate([
            hidePasswordBtn.heightAnchor.constraint(equalToConstant: 45),
            hidePasswordBtn.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 0),
            hidePasswordBtn.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14)
        ])
        
        self.view.addSubview(confirmPasswordView)
        NSLayoutConstraint.activate([
            confirmPasswordView.heightAnchor.constraint(equalToConstant: 45),
            confirmPasswordView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            confirmPasswordView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 36),
            confirmPasswordView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -36)
        ])
        
        self.view.addSubview(confirmPasswordTextField)
        NSLayoutConstraint.activate([
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 45),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordView.leadingAnchor, constant: 14),
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordView.topAnchor, constant: 0),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: confirmPasswordView.trailingAnchor, constant: -14)
        ])
        
        self.view.addSubview(confirmPasswordError)
        NSLayoutConstraint.activate([
            confirmPasswordError.heightAnchor.constraint(equalToConstant: 24),
            confirmPasswordError.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            confirmPasswordError.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 0)
        ])
        
        self.view.addSubview(hideConfirmPasswordBtn)
        NSLayoutConstraint.activate([
            hideConfirmPasswordBtn.heightAnchor.constraint(equalToConstant: 45),
            hideConfirmPasswordBtn.topAnchor.constraint(equalTo: confirmPasswordView.topAnchor, constant: 0),
            hideConfirmPasswordBtn.trailingAnchor.constraint(equalTo: confirmPasswordView.trailingAnchor, constant: -14)
        ])
        
        self.view.addSubview(confidentialLabel)
        NSLayoutConstraint.activate([
            confidentialLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            confidentialLabel.heightAnchor.constraint(equalToConstant: 44),
            confidentialLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 67),
            confidentialLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            confidentialLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -67)
        ])
        
        self.view.addSubview(toLoginLabel)
        NSLayoutConstraint.activate([
            toLoginLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            toLoginLabel.heightAnchor.constraint(equalToConstant: 20),
            toLoginLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            toLoginLabel.bottomAnchor.constraint(equalTo: confidentialLabel.topAnchor, constant: -32),
            toLoginLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        ])
        
        self.view.addSubview(registerBtn)
        NSLayoutConstraint.activate([
            registerBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            registerBtn.heightAnchor.constraint(equalToConstant: 52),
            registerBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            registerBtn.bottomAnchor.constraint(equalTo: toLoginLabel.topAnchor, constant: -16),
            registerBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -38)
        ])
        
        self.view.addSubview(tncLabel)
        NSLayoutConstraint.activate([
            tncLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tncLabel.heightAnchor.constraint(equalToConstant: 44),
            tncLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 67),
            tncLabel.bottomAnchor.constraint(equalTo: registerBtn.topAnchor, constant: -16),
            tncLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -67)
        ])
        
        resetForm()
        tncTapped()
        toLoginTapped()
        
    }
    
    func resetForm() {
        
        registerBtn.isEnabled = false
        
        usernameView.layer.borderWidth = 0
        emailView.layer.borderWidth = 0
        passwordView.layer.borderWidth = 0
        confirmPasswordView.layer.borderWidth = 0
        
        usernameError.isHidden = true
        emailError.isHidden = true
        passwordError.isHidden = true
        confirmPasswordError.isHidden = true
        
        usernameError.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        
    }
    
    @objc func onTapHidePassword() {
        if select == 1 {
            hidePasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            select -= 1
        } else if select == 0 {
            hidePasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            select += 1
        }
    }
    
    @objc func onTapHideConfirmPassword() {
        if select == 1 {
            hideConfirmPasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            confirmPasswordTextField.isSecureTextEntry = true
            select -= 1
        } else if select == 0 {
            hideConfirmPasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
            confirmPasswordTextField.isSecureTextEntry = false
            select += 1
        }
    }
    
    @objc func onTapRegister() {
        UserProfile.shared.username = usernameTextField.text ?? ""
        UserProfile.shared.email = emailTextField.text ?? ""
        UserProfile.shared.password = passwordTextField.text ?? ""
        RegisterVM.shared.register(myStruct: Token.self)
        subscribe()
        if(statusRegisterVC == "success") {
            navigationController?.pushViewController(VerifyEmailVC(), animated: true)
            print("Status: \(statusRegisterVC)")
        } else {
            print("Status: \(statusRegisterVC)")
        }
    }
    
    func subscribe() {
        RegisterVM.shared.statusRegister.subscribe(onNext: { event in
            self.statusRegisterVC = event
            print("ini event subscribe: \(self.statusRegisterVC)")
        }).disposed(by: bag)
    }
    
    //MARK: - TNC
    
    func tncTapped() {
        
        let text = "By signing up, you agree to App’s Name Terms & Conditions and Privacy Policy."
        let attribute = NSMutableAttributedString(string: text)
        attribute.addAttribute(.font, value: UIFont.poppinsRegular(size: 12), range: NSRange(location: 0, length: 38))
        attribute.addAttribute(.font, value: UIFont.poppinsBold(size: 12), range: NSRange(location: 39, length: 18))
        attribute.addAttribute(.underlineStyle, value: NSNumber(value: 1), range: NSRange(location: 39, length: 18))
        attribute.addAttribute(.foregroundColor, value: UIColor.darkPurple, range: NSRange(location: 39, length: 18))
        attribute.addAttribute(.font, value: UIFont.poppinsRegular(size: 12), range: NSRange(location: 58, length: 3))
        attribute.addAttribute(.font, value: UIFont.poppinsBold(size: 12), range: NSRange(location: 62, length: 15))
        attribute.addAttribute(.underlineStyle, value: NSNumber(value: 1), range: NSRange(location: 62, length: 15))
        attribute.addAttribute(.foregroundColor, value: UIColor.darkPurple, range: NSRange(location: 62, length: 15))
        
        tncLabel.attributedText = attribute
        
        self.tncLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapTnC(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.tncLabel.addGestureRecognizer(tapgesture)
    }
    
    @objc func onTapTnC(_ gesture: UITapGestureRecognizer) {
        guard let text = self.tncLabel.text else { return }
        let termsNConditions = (text as NSString).range(of: "Terms & Conditions")
        let privacyPolicy = (text as NSString).range(of: "Privacy Policy.")
        
        if gesture.didTapAttributedTextInLabel(label: self.tncLabel, inRange: termsNConditions) {
//            navigationController?.pushViewController(TermsnConditions(), animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: self.tncLabel, inRange: privacyPolicy){
//            navigationController?.pushViewController(PrivacyPolicy(), animated: true)
        }
    }
    //MARK: - Login
    
    func toLoginTapped() {
        let textArray = ["Sudah ada akun?", "Masuk disini!"]
        let fontArray = [UIFont.poppinsRegular(size: 14)!, UIFont.poppinsBold(size: 14)!]
        let colorArray = [UIColor.black, UIColor.darkPurple]
        
        self.toLoginLabel.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        
        self.toLoginLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapToLogin(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.toLoginLabel.addGestureRecognizer(tapgesture)
    }
    
    @objc func onTapToLogin(_ gesture: UITapGestureRecognizer) {
        guard let text = self.toLoginLabel.text else { return }
        let label = (text as NSString).range(of: "Sudah ada akun? Masuk disini!")
        
        if gesture.didTapAttributedTextInLabel(label: self.toLoginLabel, inRange: label) {
            navigationController?.pushViewController(LoginVC(), animated: true)
        }
    }
    
    //MARK: - Username
    
    @objc func usernameChanged() {
        usernameError.text = "Masukan username anda"
        let username = usernameTextField.text
        if username == "" {
            usernameError.isHidden = false
            usernameView.layer.borderWidth = 1
        } else {
            usernameError.isHidden = true
            usernameView.layer.borderWidth = 0
        }
        checkForValidForm()
    }
    
    //MARK: - Email
    
    @objc func emailChanged()
    {
        if let email = emailTextField.text{
            if let errorMessage = invalidEmail(email) {
                if email == "" {
                    emailError.text = errorMessage
                    emailView.layer.borderWidth = 1
                    emailError.isHidden = false
                } else {
                    emailView.layer.borderWidth = 0
                    emailError.isHidden = true
                }
            }
        }
        checkForValidForm()
    }
    
    func invalidEmail(_ value: String) -> String?
    {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Masukan alamat email anda"
        }
        
        return nil
    }
    
    //MARK: - Password
    
    @objc func passwordChanged() {
        if let password = passwordTextField.text
        {
            if password.count == 0 {
                passwordView.layer.borderColor = UIColor.darkPurple.cgColor
                passwordView.layer.borderWidth = 1
                passwordError.isHidden = false
                passwordError.text = "Masukan password anda"
            } else if password.count != 0 && password.count < 8 {
                passwordView.layer.borderWidth = 1
                passwordError.isHidden = false
                passwordError.text = "Password harus 8 karakter"
            } else {
                passwordView.layer.borderWidth = 0
                passwordError.isHidden = true
                    
            }
        }
        checkForValidForm()
    }
    
    //MARK: - Confirm Password
    
    @objc func confirmPasswordChanged() {
        if let confirmPassword = confirmPasswordTextField.text
        {
            if confirmPassword != passwordTextField.text && confirmPassword.count != 0 {
                confirmPasswordView.layer.borderColor = UIColor.darkPurple.cgColor
                confirmPasswordView.layer.borderWidth = 1
                confirmPasswordError.isHidden = false
                confirmPasswordError.text = "Password anda tidak sama"
            } else if confirmPassword.count == 0 {
                confirmPasswordView.layer.borderColor = UIColor.darkPurple.cgColor
                confirmPasswordView.layer.borderWidth = 1
                confirmPasswordError.isHidden = false
                confirmPasswordError.text = "Masukan konfirmasi password anda"
            } else {
                confirmPasswordView.layer.borderWidth = 0
                confirmPasswordError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func checkForValidForm()
    {
        if usernameTextField.text != "" && usernameError.isHidden == true && emailTextField.text != "" && emailError.isHidden == true && passwordError.isHidden == true && passwordTextField.text == confirmPasswordTextField.text && passwordTextField.text != "" {
            registerBtn.isEnabled = true
            registerBtn.backgroundColor = .darkPurple
            
        } else {
            registerBtn.isEnabled = false
            registerBtn.backgroundColor = .lightPurple
        }
    }
    
    //MARK: - getAttributedString
    func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?, arrayFonts:[UIFont]?) -> NSMutableAttributedString {
        
        let finalAttributedString = NSMutableAttributedString()
        
        for i in 0 ..< (arrayText?.count)! {
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
            
            if i != 0 {
                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            finalAttributedString.append(attributedStr)
        }
        return finalAttributedString
    }
}
