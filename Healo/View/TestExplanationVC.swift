//
//  TestExplanationVC.swift
//  Healo
//
//  Created by Elvina Jacia on 13/10/22.
//


import UIKit
import SnapKit

class TestExplanationVC: UIViewController {
  
    var timer = Timer()
    var isTimerStarted = false

    var duration: TimeInterval = 240 * 60 // 240 min (4 hours)

    
    private lazy var title1 : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "Tes untuk menjadi \nListener"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var imageView1 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet.circle")
        imageView.tintColor = .blackPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var testNumLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "14"
        return label
    }()
    
    private lazy var ppgLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .left
        label.text = "Penjelasan dan \nPertanyaan Pilihan Ganda"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var topStack = UIStackView()
    
    private let stripeView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkPurple
        view.alpha = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    
    private lazy var disTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .left
        label.text = "Sebelum anda mulai, ada beberapa hal \nyang harus diperhatikan :"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    private lazy var disBodyLabel1 : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .left
        label.text = "•  Anda harus menyelesaikan tes ini dalam \n   satu sesi - pastikan internet Anda \n   mendukung."
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var disBodyLabel2 : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .left
        
        let text = "•  Anda akan mendapatkan 2 poin untuk \n   setiap pertanyaan jika Anda menjawab \n   dengan benar."
        let atrText = NSMutableAttributedString(string: text)
        atrText.addAttribute(.font, value: UIFont(name: "Poppins-Bold", size: 14), range: NSRange(location: 24, length: 7))
        label.attributedText = atrText
        
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var disBodyLabel3 : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .left
        
        let text = "•  Untuk terkualifikasi menjadi seorang \n   Listener, anda harus mendapatkan \n   setidaknya 20 poin dari total 28 poin."
        let atrText = NSMutableAttributedString(string: text)
        atrText.addAttribute(.font, value: UIFont(name: "Poppins-Bold", size: 14), range: NSRange(location: 92, length: 7))
        atrText.addAttribute(.font, value: UIFont(name: "Poppins-Bold", size: 14), range: NSRange(location: 104, length: 14))
        label.attributedText = atrText
       
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var disStack = UIStackView()
    
    private lazy var mulaiButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkPurple
        button.layer.cornerRadius = 10
        button.setTitle("Mulai Tes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 16)
        button.addTarget(self, action: #selector(tapMulaiAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var hintLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 12)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Anda dapat mengambil test ulang sesuai waktu \nyang tertera"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.isHidden = true
        return label
    }()
    
    private let countDownView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkPurple
        view.alpha = 1
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
        
    }()

    private lazy var countDownLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.text = timeFormat()
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countDownView.isHidden = true
        configureUI()
    }
    
    func configureUI(){
        setupView()
        setupLayout()
    }
    
    func setupView(){
       setupBottomView()
       setupTopView()
    }
    
    func setupBottomView(){
        view.backgroundColor = .white
        
        view.addSubview(title1)
        
        topStack = UIStackView(arrangedSubviews: [imageView1, testNumLabel, ppgLabel])
        topStack.axis = .horizontal
        topStack.spacing = 8
        view.addSubview(topStack)
        
        view.addSubview(stripeView)
        
        disStack = UIStackView(arrangedSubviews: [disTitleLabel, disBodyLabel1, disBodyLabel2, disBodyLabel3])
        disStack.axis = .vertical
        disStack.spacing = self.view.frame.height > 735 ? 30 : 15
        view.addSubview(disStack)
        
        view.addSubview(mulaiButton)
        
        view.addSubview(hintLabel)
    }
    
    func setupTopView(){
        countDownView.addSubview(countDownLabel)

        view.addSubview(countDownView)
    }
    

    func setupLayout(){
        setupTitle()
        setupTopStack()
        setupStripe()
        setupDisStack()
        setupMulaiBtn()
        setupHint()
        setupCountDownLay()
        setupCountDownLabel()
    }
    
    func setupTitle() {
        title1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height > 735 ? 125 : 75)
            make.left.equalToSuperview().offset(32)
        }
    }
    
    func setupTopStack() {
        imageView1.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        topStack.snp.makeConstraints { make in
            make.top.equalTo(title1.snp.bottom).offset(self.view.frame.height > 735 ? 25 : 10)
            make.left.equalTo(32)
        }
        
    }
    
    func setupStripe() {
        stripeView.snp.makeConstraints { make in
            make.left.equalTo(32)
            make.top.equalTo(topStack.snp.bottom).offset(self.view.frame.height > 735 ? 20 : 10)
            make.height.equalTo(1)
            make.right.equalTo(-32)
        }
    }

    
    func setupDisStack() {
        disStack.snp.makeConstraints { make in
            make.left.equalTo(32)
            make.top.equalTo(stripeView.snp.bottom).offset(self.view.frame.height > 735 ? 30 : 15)
        }
    }
    
    func setupMulaiBtn() {
        mulaiButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.width.equalTo(314)
            make.height.equalTo(52)
        }
    }
    
    func setupHint(){
        hintLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func setupCountDownLay(){
        countDownView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.width.equalTo(314)
            make.height.equalTo(52)
        }
    }
    
    func setupCountDownLabel(){
        countDownLabel.snp.makeConstraints { make in
             make.centerX.equalTo(countDownView)
             make.centerY.equalTo(countDownView)
         }
    }
    
    @objc func tapMulaiAction(){
        //MARK: CALL COUNTDOWN
        setupCountDownHidden()
        setupCountDownNum()
       
    }
    
    func setupCountDownHidden(){
        hintLabel.isHidden = false
        mulaiButton.isEnabled = false
        mulaiButton.isHidden = true
        
        countDownView.isHidden = false
    }
    

    func timeFormat() -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        let seconds = Int(duration) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func setupCountDownNum(){
        setTime()
    }

    func setTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimeLabel)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeLabel(){
        duration -= 1
        countDownLabel.text = timeFormat()
    }
   

}

