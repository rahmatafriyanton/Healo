//
//  VerifyEmailVC.swift
//  Healo
//
//  Created by Hana Salsabila on 10/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class VerifyEmailVC : UIViewController {
    
    private var statusVerifyEmailVC : String = ""
    private var bag = DisposeBag()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.text = "Verifikasi Email Anda"
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Masukkan 4 digit angka yang dikirimkan ke email Anda"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let digit1View : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var digit1TextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        textField.becomeFirstResponder()
        textField.font = .poppinsMedium(size: 25)
        textField.keyboardType = .numberPad
        textField.text = ""
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let digit2View : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var digit2TextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        textField.font = .poppinsMedium(size: 25)
        textField.keyboardType = .numberPad
        textField.text = ""
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let digit3View : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var digit3TextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        textField.font = .poppinsMedium(size: 25)
        textField.keyboardType = .numberPad
        textField.text = ""
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var digit4View : UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var digit4TextField : UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(toSetProfile), for: .editingChanged)
        textField.font = .poppinsMedium(size: 25)
        textField.keyboardType = .numberPad
        textField.text = ""
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var askLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.text = "Anda tidak menerima kode?"
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sendAgainBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapBtnSendAgain), for: .touchUpInside)
        btn.setTitle("Kirim ulang kode", for: .normal)
        btn.setTitleColor(.darkPurple, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var anotherLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 14)
        label.isHidden = true
        label.text = "Kode baru sudah dikirim!"
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timer: Timer?
    var totalTime = 0
    var sendAgainTime = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if digit4TextField.text != "" {
            toSetProfile()
        }
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17) ?? "",NSAttributedString.Key.foregroundColor : UIColor.darkPurple], for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupUI() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupNavBar()
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -38)
        ])
        
        self.view.addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.heightAnchor.constraint(equalToConstant: 48),
            detailLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 38),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            detailLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -38)
        ])
        
        self.view.addSubview(digit2View)
        NSLayoutConstraint.activate([
            digit2View.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 32),
            digit2View.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -40.5),
            digit2View.widthAnchor.constraint(equalToConstant: 71),
            digit2View.heightAnchor.constraint(equalToConstant: 71)
        ])
        
        self.view.addSubview(digit2TextField)
        NSLayoutConstraint.activate([
            digit2TextField.leadingAnchor.constraint(equalTo: digit2View
                .leadingAnchor, constant: 0),
            digit2TextField.trailingAnchor.constraint(equalTo: digit2View.trailingAnchor, constant: -0),
            digit2TextField.topAnchor.constraint(equalTo: digit2View.topAnchor, constant: 0),
            digit2TextField.heightAnchor.constraint(equalToConstant: 71)
        ])
        
        self.view.addSubview(digit1View)
        NSLayoutConstraint.activate([
            digit1View.trailingAnchor.constraint(equalTo: digit2View.leadingAnchor, constant: -10),
            digit1View.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 32),
            digit1View.widthAnchor.constraint(equalToConstant: 71),
            digit1View.heightAnchor.constraint(equalToConstant: 71)
        ])
        
        self.view.addSubview(digit1TextField)
        NSLayoutConstraint.activate([
            digit1TextField.heightAnchor.constraint(equalToConstant: 71),
            digit1TextField.leadingAnchor.constraint(equalTo: digit1View.leadingAnchor, constant: 0),
            digit1TextField.topAnchor.constraint(equalTo: digit1View.topAnchor, constant: 0),
            digit1TextField.trailingAnchor.constraint(equalTo: digit1View.trailingAnchor, constant: 0)
        ])
        
        self.view.addSubview(digit3View)
        NSLayoutConstraint.activate([
            digit3View.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 40.5),
            digit3View.heightAnchor.constraint(equalToConstant: 71),
            digit3View.leadingAnchor.constraint(equalTo: digit2View.trailingAnchor, constant: 10),
            digit3View.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 32),
            digit3View.widthAnchor.constraint(equalToConstant: 71)
        ])
        
        self.view.addSubview(digit3TextField)
        NSLayoutConstraint.activate([
            digit3TextField.heightAnchor.constraint(equalToConstant: 71),
            digit3TextField.leadingAnchor.constraint(equalTo: digit3View.leadingAnchor, constant: 0),
            digit3TextField.topAnchor.constraint(equalTo: digit3View.topAnchor, constant: 0),
            digit3TextField.trailingAnchor.constraint(equalTo: digit3View.trailingAnchor, constant: 0)
        ])
        
        self.view.addSubview(digit4View)
        NSLayoutConstraint.activate([
            digit4View.heightAnchor.constraint(equalToConstant: 71),
            digit4View.leadingAnchor.constraint(equalTo: digit3View.trailingAnchor, constant: 10),
            digit4View.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 32),
            digit4View.widthAnchor.constraint(equalToConstant: 71)
        ])
        
        self.view.addSubview(digit4TextField)
        NSLayoutConstraint.activate([
            digit4TextField.leadingAnchor.constraint(equalTo: digit4View.leadingAnchor, constant: 0),
            digit4TextField.heightAnchor.constraint(equalToConstant: 71),
            digit4TextField.topAnchor.constraint(equalTo: digit4View.topAnchor, constant: 0),
            digit4TextField.trailingAnchor.constraint(equalTo: digit4View.trailingAnchor, constant: 0)
        ])
        self.view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 21),
            timeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 169),
            timeLabel.topAnchor.constraint(equalTo: digit2View.bottomAnchor, constant: 32),
            timeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -169)
        ])
        
        self.view.addSubview(askLabel)
        NSLayoutConstraint.activate([
            askLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            askLabel.heightAnchor.constraint(equalToConstant: 21),
            askLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 95),
            askLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            askLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -95)
        ])
        
        self.view.addSubview(sendAgainBtn)
        NSLayoutConstraint.activate([
            sendAgainBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            sendAgainBtn.heightAnchor.constraint(equalToConstant: 21),
            sendAgainBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 134),
            sendAgainBtn.topAnchor.constraint(equalTo: askLabel.bottomAnchor, constant: 4),
            sendAgainBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -134)
        ])
        
        self.view.addSubview(anotherLabel)
        NSLayoutConstraint.activate([
            anotherLabel.heightAnchor.constraint(equalToConstant: 21),
            anotherLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            anotherLabel.topAnchor.constraint(equalTo: sendAgainBtn.bottomAnchor, constant: 4)
        ])
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 && text?.count != 2 {
            switch textField {
            case digit1TextField :
                digit2TextField.becomeFirstResponder()
            case digit2TextField :
                digit3TextField.becomeFirstResponder()
            case digit3TextField :
                digit4TextField.becomeFirstResponder()
            case digit4TextField :
                digit4TextField.resignFirstResponder()
                self.dismissKeyboard()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case digit1TextField :
                digit1TextField.becomeFirstResponder()
            case digit2TextField :
                digit1TextField.becomeFirstResponder()
            case digit3TextField :
                digit2TextField.becomeFirstResponder()
            case digit4TextField :
                digit3TextField.becomeFirstResponder()
            default:
                break
            }
        } else {
        }
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func toSetProfile() {
        
        var digit1 = digit1TextField.text!
        print("ini digit1:\(digit1)")
        var digit2 = digit2TextField.text!
        var digit3 = digit3TextField.text!
        var digit4 = digit4TextField.text!
        
        let allDigits = Int("\(digit1)\(digit2)\(digit3)\(digit4)")
        UserProfile.shared.userEmailValidationKey = allDigits!
        print(allDigits!)
        VerifyEmailVM.shared.verifyEmail(myStruct: [String].self)
        subscribe()
        while(true){
            if(statusVerifyEmailVC == "Failed") {
//                navigationController?.pushViewController(SetProfileVC(), animated: true)
                print("ini gagal:\(statusVerifyEmailVC)")
                break
                
            } else if(statusVerifyEmailVC == "Success" && digit1 != "" && digit2 != "" && digit3 != "" && digit4 != "") {
                navigationController?.pushViewController(SetProfileVC(), animated: true)
                print("ini status:\(statusVerifyEmailVC)")
                break
            }
        }
    }
    
    func subscribe() {
        VerifyEmailVM.shared.statusVerifyEmail.subscribe(onNext: { event in
            self.statusVerifyEmailVC = event
            print("ini event subscribe: \(self.statusVerifyEmailVC)")
        }).disposed(by: bag)
    }
    
    private func startOtpTimer() {
        self.totalTime = 300
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateOTPTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateOTPTimer() {
        print(self.totalTime)
        self.timeLabel.text = self.timeFormatted(self.totalTime) // will show timer
        
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    @objc func onTapBtnSendAgain() {
        startOtpTimer()
        startSendAgainTimer()
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startSendAgainTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSendAgainTimer), userInfo: nil, repeats: true)
    }
        
    @objc func updateSendAgainTimer() {
        print(self.sendAgainTime)
        self.anotherLabel.text = "Kode baru sudah dikirim!" // will show timer
        
        if sendAgainTime != 0 {
            sendAgainTime -= 1  // decrease counter timer
            anotherLabel.isHidden = false
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
            anotherLabel.isHidden = true
        }
    }
    
    private func checkForValidForm()
    {
        if askLabel.isHidden == true && anotherLabel.isHidden == true && timeLabel.isHidden == true {
            sendAgainBtn.backgroundColor = .lightPurple
            sendAgainBtn.isEnabled = true
        } else {
            sendAgainBtn.backgroundColor = .darkPurple
            sendAgainBtn.isEnabled = false
        }
    }
}
