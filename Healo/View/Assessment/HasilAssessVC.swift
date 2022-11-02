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
    
    let currentDateTime = Date()
    
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupConfiguration()
        subscribe()
    }
    
    @objc func tapIfSuccess(){
        print("successsss")
       
       let tvc = ListenerTabBarVC()
       tvc.modalPresentationStyle = .fullScreen
       present(tvc, animated: true, completion: nil)
    }
    
    @objc func tapIfFail(){
        print("failll")
        
        // insert navigation to assessment intro
        let tvc = TestExplanationVC()
        tvc.modalPresentationStyle = .fullScreen
        present(tvc, animated: true, completion: nil)
    }
    
    func subscribe() {
        AssessmentResultVM.shared.assResult.subscribe(onNext: { [self] event in
            print("yang sudah dioper: \(event)")
            poinLabel.text = "Poin: \(event.score)/\(event.total_score)"
            if(event.status == "success") {
                titleLabel.text = "Selamat!"
                centerImage.image = UIImage(named: "congrats-illus")?.withRenderingMode(.alwaysOriginal)
                descLabel.text = "Anda telah berhasil melewati test untuk menjadi Listener. Sekarang, anda dapat melanjutkan untuk masuk ke aplikasi dan memulai chatting dengan Seeker!"
                nextButton.addTarget(self, action: #selector(tapIfSuccess), for: .touchUpInside)
                UserProfile.shared.userAssessStatus = "Success"
            } else if (event.status == "fail") {
                titleLabel.text = "Maaf!"
                centerImage.image = UIImage(named: "sad-illus")?.withRenderingMode(.alwaysOriginal)
                descLabel.text = "Maaf, anda belum berhasil melewati test untuk menjadi Listener. Anda dapat mencoba untuk mengambil kembali test Listener yang ada."
                nextButton.addTarget(self, action: #selector(tapIfFail), for: .touchUpInside)
                UserProfile.shared.userAssessStatus = "Failed"
                UserProfile.shared.userFinishAssessTime = currentDateTime.timeIntervalSince1970
            } else {
                titleLabel.text = "something went wrong"
                
                //MARK: Kalau ini nanti kalian mau hapus gapapa juga -el
                UserProfile.shared.userAssessStatus = "Failed"
                nextButton.addTarget(self, action: #selector(tapIfFail), for: .touchUpInside)
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
