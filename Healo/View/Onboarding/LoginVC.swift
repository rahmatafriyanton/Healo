//
//  LoginVC.swift
//  Healo
//
//  Created by Hana Salsabila on 09/10/22.
//

import UIKit
import AuthenticationServices
import RxSwift
import RxCocoa

class LoginVC : UIViewController {
    
    private var statusLoginVC : String = ""
    private var bag = DisposeBag()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.text = "Selamat Datang Kembali!"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.font = .poppinsRegular(size: 14)
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 10
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.font = .poppinsRegular(size: 14)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var hidePasswordBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapHidePassword), for: .touchUpInside)
        btn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btn.tintColor = .greyHide
        btn.titleLabel?.font = .poppinsRegular(size: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var forgotPasswordBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapForgotPassword), for: .touchUpInside)
        btn.setTitle("Lupa Password?", for: .normal)
        btn.setTitleColor(.darkPurple, for: .normal)
        btn.titleLabel?.font = UIFont.poppinsBold(size: 14)
        btn.titleLabel?.textAlignment = .left
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var loginBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        btn.backgroundColor = .darkPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("Masuk", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let separatorLine = Separator()
    
    private lazy var separatorLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .poppinsBold(size: 14)
        label.text = "atau"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginAppleBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapSignInApple), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 15
        btn.setImage(UIImage(systemName: "applelogo"), for: .normal)
        btn.setTitle("  Sign in with Apple", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
 
    private lazy var toRegisterLabel : UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 14) ?? "",NSAttributedString.Key.foregroundColor : UIColor.darkPurple], for: .normal)
        navigationController?.navigationBar.tintColor = .darkPurple
    }
    
    private func setupUI() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        UserProfile.shared.userRole = 0
        setupNavBar()
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 104)
        ])
            
        self.view.addSubview(emailView)
        NSLayoutConstraint.activate([
            emailView.heightAnchor.constraint(equalToConstant: 45),
            emailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 37),
            emailView.topAnchor.constraint(equalTo:
                    titleLabel.bottomAnchor, constant: 24),
            emailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -37)
        ])

        self.view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 14),
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 0),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -14)
        ])

        self.view.addSubview(passwordView)
        NSLayoutConstraint.activate([
            passwordView.heightAnchor.constraint(equalToConstant: 45),
            passwordView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 37),
            passwordView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -37)
        ])

        self.view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 14),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 0)
        ])
        
        self.view.addSubview(hidePasswordBtn)
        NSLayoutConstraint.activate([
            hidePasswordBtn.heightAnchor.constraint(equalToConstant: 17),
            hidePasswordBtn.leadingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 5),
            hidePasswordBtn.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 14),
            hidePasswordBtn.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14),
            hidePasswordBtn.widthAnchor.constraint(equalToConstant: 25),
        ])

        self.view.addSubview(forgotPasswordBtn)
        NSLayoutConstraint.activate([
            forgotPasswordBtn.heightAnchor.constraint(equalToConstant: 24),
            forgotPasswordBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:  37),
            forgotPasswordBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8)
        ])

        self.view.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginBtn.heightAnchor.constraint(equalToConstant: 52),
            loginBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 78),
            loginBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -38),
            loginBtn.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor)
        ])

        self.view.addSubview(separatorLine)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLine.heightAnchor.constraint(equalToConstant: 18),
            separatorLine.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: -38),
            separatorLine.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 38)
        ])

        self.view.addSubview(separatorLabel)
        NSLayoutConstraint.activate([
            separatorLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            separatorLabel.heightAnchor.constraint(equalToConstant: 18),
            separatorLabel.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 16),
            separatorLabel.widthAnchor.constraint(equalToConstant: 75)
        ])

        self.view.addSubview(loginAppleBtn)
        NSLayoutConstraint.activate([
            loginAppleBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginAppleBtn.heightAnchor.constraint(equalToConstant: 52),
            loginAppleBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            loginAppleBtn.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 16),
            loginAppleBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -38),
            loginAppleBtn.widthAnchor.constraint(equalTo: loginBtn.widthAnchor),
        ])

        self.view.addSubview(toRegisterLabel)
        NSLayoutConstraint.activate([
            toRegisterLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toRegisterLabel.heightAnchor.constraint(equalToConstant: 20),
            toRegisterLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            toRegisterLabel.topAnchor.constraint(equalTo: loginAppleBtn.bottomAnchor, constant: 79),
            toRegisterLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        ])
        
        toRegisterTapped()
    }
    
    @objc func onTapHidePassword() {
        if select == 0 {
            hidePasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            select += 1
        } else if select == 1 {
            hidePasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            select -= 1
        }
    }
    
    @objc func onTapForgotPassword() {
//        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc func onTapLogin() {
        UserProfile.shared.email = emailTextField.text ?? ""
        UserProfile.shared.password = passwordTextField.text ?? ""
        LoginVM.shared.login(myStruct: Token.self)
        GetUserVM.shared.getUser(myStruct: User.self)
        subscribe()
        if(statusLoginVC == "success") {
            // navigate masuk tabbar sesuai role
            if(UserProfile.shared.userRole == 2){
                let svc = SeekerTabBarVC()
                svc.modalPresentationStyle = .fullScreen
                present(svc, animated: true, completion: nil)
            } else if (UserProfile.shared.userRole == 1){
                let tvc = ListenerTabBarVC()
                tvc.modalPresentationStyle = .fullScreen
                present(tvc, animated: true, completion: nil)
            }
        }
    }
    
    func subscribe() {
        LoginVM.shared.statusLogin.subscribe(onNext: { event in
            self.statusLoginVC = event
            print("ini event subscribe: \(self.statusLoginVC)")
        }).disposed(by: bag)
    }
    
    @objc func onTapSignInApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    private func toRegisterTapped() {
        let textArray = ["Belum ada akun?", "Buat akun baru"]
        let fontArray = [UIFont.poppinsRegular(size: 14)!, UIFont.poppinsBold(size: 14)!]
        let colorArray = [UIColor.black, UIColor.darkPurple]
        
        self.toRegisterLabel.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        
        self.toRegisterLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(onTapToRegisterLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.toRegisterLabel.addGestureRecognizer(tapgesture)
    }
    
    @objc func onTapToRegisterLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.toRegisterLabel.text else { return }
        let label = (text as NSString).range(of: "Belum ada akun? Buat akun baru")

        if gesture.didTapAttributedTextInLabel(label: self.toRegisterLabel, inRange: label) {
            navigationController?.pushViewController(RegisterVC(), animated: true)
        }
    }
    
    //MARK:- getAttributedString
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

extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            let firstName = credential.fullName?.givenName
            let lastName = credential.fullName?.familyName
            let email = credential.email
            break
        default:
            break
        }
        navigationController?.pushViewController(ChatListVC(), animated: true)
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

class Separator: UIView {

    let line = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black

        NSLayoutConstraint.activate([
            line.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.67)
        ])
    }
}
