//
//  HasilAssessVC.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 12/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class HasilAssessVC: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont(name: "Poppins-SemiBold", size: 21.0)
        return view
    }()
    
    private lazy var centerImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var poinLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Poppins-SemiBold", size: 18.0)
        view.textColor = .blackPurple
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    private lazy var descLabel: UILabel = {
       let view = UILabel()
        view.font = UIFont(name: "Poppins-Regular", size: 16.0)
        view.textColor = .blackPurple
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var nextButton: ReusableNextButton = {
        let view = ReusableNextButton(text: "Berikutnya")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConfiguration()
        subscribe()
    }
    
    @objc func tapIfSuccess(){
        print("successsss")
        // insert navigation to main page
    }
    
    @objc func tapIfFail(){
        print("failll")
        // insert navigation to assessment intro
    }
    
    func subscribe() {
        AssessmentResultVM.shared.assResult.subscribe(onNext: { [self] event in
            print("yang sudah diuoper: \(event)")
            poinLabel.text = "Poin: \(event.score)/\(event.total_score)"
            if(event.status == "success") {
                titleLabel.text = "Selamat!"
                centerImage.image = UIImage(named: "congrats-illus")?.withRenderingMode(.alwaysOriginal)
                descLabel.text = "Anda telah berhasil melewati test untuk menjadi Listener. Sekarang, anda dapat melanjutkan untuk masuk ke aplikasi dan memulai chatting dengan Seeker!"
                nextButton.addTarget(self, action: #selector(tapIfSuccess), for: .touchUpInside)
            } else if (event.status == "fail") {
                titleLabel.text = "Maaf!"
                centerImage.image = UIImage(named: "sad-illus")?.withRenderingMode(.alwaysOriginal)
                descLabel.text = "Maaf, anda belum berhasil melewati test untuk menjadi Listener. Anda dapat mencoba untuk mengambil kembali test Listener yang ada."
                nextButton.addTarget(self, action: #selector(tapIfFail), for: .touchUpInside)
            } else {
                titleLabel.text = "something went wrong"
            }
        }).disposed(by: disposeBag)
    }
    
    func setupConfiguration() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(146)
            make.left.right.equalToSuperview().inset(50)
        }
        
        view.addSubview(centerImage)
        centerImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.height.equalTo(216)
            make.width.equalTo(221)
        }
        
        view.addSubview(poinLabel)
        poinLabel.snp.makeConstraints { make in
            make.top.equalTo(centerImage.snp.bottom).offset(37)
            make.left.right.equalToSuperview().inset(38)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(poinLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(38)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }

    }

}
