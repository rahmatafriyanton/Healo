//
//  PairingLoadingVC.swift
//  Healo
//
//  Created by Hana Salsabila on 18/10/22.
//

import UIKit

class PairingLoadingVC: UIViewController {
    
    var paired = false

    private lazy var secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pairing-loading")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.numberOfLines = 0
        label.text = "Mencarikan Listener \n untukmu.."
        label.textAlignment = .center
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel : UILabel = {
       let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.numberOfLines = 0
        label.text = "Jangan tutup aplikasi ini"
        label.textAlignment = .center
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var proTipLabel : UILabel = {
        let label = UILabel()
        let text = "Pro-Tip: Jangan bagikan informasi pribadi Anda kepada orang lain!"
        let attribute = NSMutableAttributedString(string: text)
        attribute.addAttribute(.font, value: UIFont.poppinsSemiBold(size: 16), range: NSRange(location: 0, length: 8))
        attribute.addAttribute(.font, value: UIFont.poppinsRegular(size: 16), range: NSRange(location: 10, length: text.count-10))
        label.attributedText = attribute
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .greyPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SocketHandler.shared.mSocket.on("chat_session_created") { ( data, ack) -> Void in
            self.paired = true
            self.navigationController?.pushViewController(PairingSuccessVC(), animated: false)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
            if(!self.paired){
                SocketHandler.shared.closeConnection()
                self.navigationController?.pushViewController(PairingFailedVC(), animated: false)
            }
        }
    }
    
    private func setupNavBar() {
        navigationItem.title = "Pairing"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsBold(size: 25)!]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .lightPurple
        
        setupNavBar()
        
        self.view.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            secondView.heightAnchor.constraint(equalToConstant: 718),
            secondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            secondView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 33),
            secondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
        
        self.view.addSubview(loadingImage)
        NSLayoutConstraint.activate([
            loadingImage.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            loadingImage.heightAnchor.constraint(equalToConstant: 163),
            loadingImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 118),
            loadingImage.widthAnchor.constraint(equalToConstant: 172)
        ])
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 64),
            titleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 42),
            titleLabel.topAnchor.constraint(equalTo: loadingImage.bottomAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -42),
        ])
        
        self.view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 24),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
        
        self.view.addSubview(proTipLabel)
        NSLayoutConstraint.activate([
            proTipLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            proTipLabel.heightAnchor.constraint(equalToConstant: 48),
            proTipLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 37),
            proTipLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 174),
            proTipLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -37),
        ])
    }
}
