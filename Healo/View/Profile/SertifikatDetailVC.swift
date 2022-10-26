//
//  SertifikatDetailVC.swift
//  Healo
//
//  Created by Hana Salsabila on 22/10/22.
//

import UIKit

class SertifikatDetailVC: UIViewController {

    private lazy var sertifikatImage : UIImageView = {
        let image = UIImageView()
        let sertifikat = "pairing-failed"
        image.backgroundColor = .greyHide
        image.image = UIImage(named: sertifikat)
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var downloadButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .darkPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("Unduh Sertifikat", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .poppinsBold(size: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsSemiBold(size: 18)!]
        navigationController?.navigationBar.tintColor = .darkPurple
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        setupNavBar()
        
        view.addSubview(sertifikatImage)
        setImageConstraints()
        view.addSubview(downloadButton)
        setButtonConstraints()
    }
    
    func setImageConstraints() {
        NSLayoutConstraint.activate([
            sertifikatImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            sertifikatImage.heightAnchor.constraint(equalToConstant: 174),
            sertifikatImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 179),
            sertifikatImage.widthAnchor.constraint(equalToConstant: 350)
            
        ])
    }
    
    func setButtonConstraints() {
        NSLayoutConstraint.activate([
            downloadButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 52),
            downloadButton.topAnchor.constraint(equalTo: sertifikatImage.bottomAnchor, constant: 138),
            downloadButton.widthAnchor.constraint(equalToConstant: 314)
        ])
    }
    

   

}
