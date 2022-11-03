//
//  PostReflectionVC.swift
//  Healo
//
//  Created by Hana Salsabila on 31/10/22.
//

import UIKit

class PostReflectionVC: UIViewController {
    
    private let moods = ["😌", "🥰", "😭", "🥲", "😖", "😐" ]
    private let moodsName = ["Tenang", "Senang", "Sedih", "Insecure", "Cemas", "Biasa Saja"]
    
    var writtenPR : String = ""
    var selectedMood : String = ""
    
    var mood1 = 0
    var mood2 = 0
    var mood3 = 0
    var mood4 = 0
    var mood5 = 0
    var mood6 = 0
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    private lazy var pRScrollView : UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .none
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    private lazy var secondView : UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var pRTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Post-Reflection"
        label.font = .poppinsSemiBold(size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pRSubtitleLabel : UILabel = {
        let label = UILabel()
        var listenerName = "johndoe"
        label.text = "Apa yang Anda dapatkan dari sesi Anda dengan @\(listenerName)?"
        label.font = .poppinsRegular(size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postReflectionView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.blackPurple.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var PRTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = "Contoh: Saya menjadi lebih tenang setelah saya membuka perasaan saya."
        textView.font = .poppinsRegular(size: 16)
        textView.textColor = .greyPlaceholder
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.addDoneButtonOnKeyboard()
//        textView.returnKeyType = .done
        textView.textAlignment = .left
        return textView
    }()

    private lazy var countLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.text = "0/150"
        label.textAlignment = .right
        label.textColor = .greyPlaceholder
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var moodTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Mood Check Out"
        label.font = .poppinsSemiBold(size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var moodSubtitleLabel : UILabel = {
        let label = UILabel()
        var listenerName = "johndoe"
        label.text = "Bagaimana perasaan Anda setelah sesi Anda dengan @\(listenerName)?"
        label.font = .poppinsRegular(size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mood1Button : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapMood1), for: .touchUpInside)
        btn.backgroundColor = .greyMood
        btn.setTitle(moods[0], for: .normal)
        btn.titleLabel?.font = .poppinsRegular(size: 28)
        btn.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.borderColor = UIColor.darkPurple.cgColor
        btn.layer.borderWidth = 0
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mood1Label : UILabel = {
        let label = UILabel()
        label.text = moodsName[0]
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var check1Image : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.backgroundColor = .white
        image.frame.size = CGSize(width: 17, height: 17)
        image.tintColor = .darkPurple
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mood2Button : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapMood2), for: .touchUpInside)
        btn.backgroundColor = .greyMood
        btn.setTitle(moods[1], for: .normal)
        btn.titleLabel?.font = .poppinsRegular(size: 28)
        btn.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.borderColor = UIColor.darkPurple.cgColor
        btn.layer.borderWidth = 0
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mood2Label : UILabel = {
        let label = UILabel()
        label.text = moodsName[1]
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var check2Image : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.backgroundColor = .white
        image.frame.size = CGSize(width: 17, height: 17)
        image.tintColor = .darkPurple
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mood3Button : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapMood3), for: .touchUpInside)
        btn.backgroundColor = .greyMood
        btn.setTitle(moods[2], for: .normal)
        btn.titleLabel?.font = .poppinsRegular(size: 28)
        btn.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.borderColor = UIColor.darkPurple.cgColor
        btn.layer.borderWidth = 0
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mood3Label : UILabel = {
        let label = UILabel()
        label.text = moodsName[2]
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var check3Image : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.backgroundColor = .white
        image.frame.size = CGSize(width: 17, height: 17)
        image.tintColor = .darkPurple
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mood4Button : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapMood4), for: .touchUpInside)
        btn.backgroundColor = .greyMood
        btn.setTitle(moods[3], for: .normal)
        btn.titleLabel?.font = .poppinsRegular(size: 28)
        btn.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.borderColor = UIColor.darkPurple.cgColor
        btn.layer.borderWidth = 0
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mood4Label : UILabel = {
        let label = UILabel()
        label.text = moodsName[3]
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var check4Image : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.backgroundColor = .white
        image.frame.size = CGSize(width: 17, height: 17)
        image.tintColor = .darkPurple
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mood5Button : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapMood5), for: .touchUpInside)
        btn.backgroundColor = .greyMood
        btn.setTitle(moods[4], for: .normal)
        btn.titleLabel?.font = .poppinsRegular(size: 28)
        btn.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.borderColor = UIColor.darkPurple.cgColor
        btn.layer.borderWidth = 0
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mood5Label : UILabel = {
        let label = UILabel()
        label.text = moodsName[4]
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var check5Image : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.backgroundColor = .white
        image.frame.size = CGSize(width: 17, height: 17)
        image.tintColor = .darkPurple
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var mood6Button : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onTapMood6), for: .touchUpInside)
        btn.backgroundColor = .greyMood
        btn.setTitle(moods[5], for: .normal)
        btn.titleLabel?.font = .poppinsRegular(size: 28)
        btn.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.borderColor = UIColor.darkPurple.cgColor
        btn.layer.borderWidth = 0
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mood6Label : UILabel = {
        let label = UILabel()
        label.text = moodsName[5]
        label.font = .poppinsRegular(size: 14)
        label.textColor = .blackPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var check6Image : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.backgroundColor = .white
        image.frame.size = CGSize(width: 17, height: 17)
        image.tintColor = .darkPurple
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAll()
    }
    
    private func configureAll() {
        setupNavBar()
        setupPRUI()
        setupPRConstraint()
        setupMoodUI()
        setupMoodConstraint()
    }
    
    private func setupNavBar() {
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(onTapSave))
        navigationItem.rightBarButtonItem!.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.poppinsMedium(size: 14)!,
            NSAttributedString.Key.foregroundColor : UIColor.darkPurple,
        ], for: .normal)
        
    }
    
    private func setupPRUI() {
        view.backgroundColor = .white
        
        view.addSubview(pRScrollView)
        pRScrollView.addSubview(secondView)
        secondView.addSubview(pRTitleLabel)
        secondView.addSubview(pRSubtitleLabel)
        secondView.addSubview(postReflectionView)
        secondView.addSubview(PRTextView)
        secondView.addSubview(countLabel)
    }
    
    private func setupPRConstraint() {
        setPRScrollViewConstraint()
        setSecondViewConstraint()
        setPRTitleConstraint()
        setPRSubtitleConstraint()
        setPostReflectionViewConstraint()
        setPRTextViewConstraint()
        setCountLabelConstraint()
    }
    
    private func setupMoodUI() {
        secondView.addSubview(moodTitleLabel)
        secondView.addSubview(moodSubtitleLabel)
        secondView.addSubview(mood1Button)
        secondView.addSubview(mood1Label)
        secondView.addSubview(check1Image)
        secondView.addSubview(mood2Button)
        secondView.addSubview(mood2Label)
        secondView.addSubview(check2Image)
        secondView.addSubview(mood3Button)
        secondView.addSubview(mood3Label)
        secondView.addSubview(check3Image)
        secondView.addSubview(mood4Button)
        secondView.addSubview(mood4Label)
        secondView.addSubview(check4Image)
        secondView.addSubview(mood5Button)
        secondView.addSubview(mood5Label)
        secondView.addSubview(check5Image)
        secondView.addSubview(mood6Button)
        secondView.addSubview(mood6Label)
        secondView.addSubview(check6Image)
    }
    
    private func setupMoodConstraint() {
        setMoodTitleLabelConstraint()
        setMoodSubtitleLabelConstraint()
        setMood1Constraint()
        setMood2Constraint()
        setMood3Constraint()
        setMood4Constraint()
        setMood5Constraint()
        setMood6Constraint()
    }
    
    private func setPRScrollViewConstraint() {
        NSLayoutConstraint.activate([
            pRScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pRScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pRScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pRScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func setSecondViewConstraint() {
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: pRScrollView.topAnchor, constant: 0),
            secondView.leadingAnchor.constraint(equalTo: pRScrollView.leadingAnchor, constant: 0),
            secondView.trailingAnchor.constraint(equalTo: pRScrollView.trailingAnchor, constant: 0),
            secondView.bottomAnchor.constraint(equalTo: pRScrollView.bottomAnchor, constant: 0),
        ])
    }
    
    private func setPRTitleConstraint() {
        NSLayoutConstraint.activate([
            pRTitleLabel.topAnchor.constraint(equalTo: secondView.safeAreaLayoutGuide.topAnchor, constant: 32),
            pRTitleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 34),
            pRTitleLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -34),
            pRTitleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setPRSubtitleConstraint() {
        NSLayoutConstraint.activate([
            pRSubtitleLabel.topAnchor.constraint(equalTo: pRTitleLabel.bottomAnchor, constant: 8),
            pRSubtitleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 34),
            pRSubtitleLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -34),
            pRSubtitleLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setPostReflectionViewConstraint() {
        NSLayoutConstraint.activate([
            postReflectionView.topAnchor.constraint(equalTo: pRSubtitleLabel.bottomAnchor, constant: 24),
            postReflectionView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 34),
            postReflectionView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -34),
            postReflectionView.heightAnchor.constraint(equalToConstant: 371)
        ])
    }
    
    private func setPRTextViewConstraint() {
        NSLayoutConstraint.activate([
            PRTextView.topAnchor.constraint(equalTo: postReflectionView.topAnchor, constant: 20),
            PRTextView.leadingAnchor.constraint(equalTo: postReflectionView.leadingAnchor, constant: 17),
            PRTextView.trailingAnchor.constraint(equalTo: postReflectionView.trailingAnchor, constant: -17),
            PRTextView.bottomAnchor.constraint(equalTo: postReflectionView.bottomAnchor, constant: -34)
        ])
    }
    
    private func setCountLabelConstraint() {
        NSLayoutConstraint.activate([
            countLabel.trailingAnchor.constraint(equalTo: postReflectionView.trailingAnchor, constant: -17),
            countLabel.bottomAnchor.constraint(equalTo: postReflectionView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setMoodTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            moodTitleLabel.topAnchor.constraint(equalTo: postReflectionView.bottomAnchor, constant: 24),
            moodTitleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 36),
        ])
    }
    
    private func setMoodSubtitleLabelConstraint() {
        NSLayoutConstraint.activate([
            moodSubtitleLabel.topAnchor.constraint(equalTo: moodTitleLabel.bottomAnchor, constant: 4),
            moodSubtitleLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 36),
            moodSubtitleLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -36),
            moodSubtitleLabel.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func setMood1Constraint() {
        NSLayoutConstraint.activate([
            mood1Button.topAnchor.constraint(equalTo: moodSubtitleLabel.bottomAnchor, constant: 16),
            mood1Button.trailingAnchor.constraint(equalTo: mood2Button.leadingAnchor, constant: -34),
            mood1Button.heightAnchor.constraint(equalToConstant: 52),
            mood1Button.widthAnchor.constraint(equalToConstant: 52),
            check1Image.centerXAnchor.constraint(equalTo: mood1Button.centerXAnchor, constant: 17),
            check1Image.centerYAnchor.constraint(equalTo: mood1Button.centerYAnchor, constant: -17),
            mood1Label.topAnchor.constraint(equalTo: mood1Button.bottomAnchor, constant: 8),
            mood1Label.centerXAnchor.constraint(equalTo: mood1Button.centerXAnchor)
        ])
    }
    
    private func setMood2Constraint() {
        NSLayoutConstraint.activate([
            mood2Button.topAnchor.constraint(equalTo: moodSubtitleLabel.bottomAnchor, constant: 16),
            mood2Button.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: -47),
            mood2Button.heightAnchor.constraint(equalToConstant: 52),
            mood2Button.widthAnchor.constraint(equalToConstant: 52),
            mood2Label.topAnchor.constraint(equalTo: mood2Button.bottomAnchor, constant: 8),
            mood2Label.centerXAnchor.constraint(equalTo: mood2Button.centerXAnchor),
            check2Image.centerXAnchor.constraint(equalTo: mood2Button.centerXAnchor, constant: 17),
            check2Image.centerYAnchor.constraint(equalTo: mood2Button.centerYAnchor, constant: -17)
        ])
    }
    
    private func setMood3Constraint() {
        NSLayoutConstraint.activate([
            mood3Button.topAnchor.constraint(equalTo: moodSubtitleLabel.bottomAnchor, constant: 16),
            mood3Button.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: 47),
            mood3Button.heightAnchor.constraint(equalToConstant: 52),
            mood3Button.widthAnchor.constraint(equalToConstant: 52),
            mood3Label.topAnchor.constraint(equalTo: mood3Button.bottomAnchor, constant: 8),
            mood3Label.centerXAnchor.constraint(equalTo: mood3Button.centerXAnchor),
            check3Image.centerXAnchor.constraint(equalTo: mood3Button.centerXAnchor, constant: 17),
            check3Image.centerYAnchor.constraint(equalTo: mood3Button.centerYAnchor, constant: -17)
        ])
    }
    
    private func setMood4Constraint() {
        NSLayoutConstraint.activate([
            mood4Button.topAnchor.constraint(equalTo: moodSubtitleLabel.bottomAnchor, constant: 16),
            mood4Button.leadingAnchor.constraint(equalTo: mood3Button.trailingAnchor, constant: 34),
            mood4Button.heightAnchor.constraint(equalToConstant: 52),
            mood4Button.widthAnchor.constraint(equalToConstant: 52),
            mood4Label.topAnchor.constraint(equalTo: mood4Button.bottomAnchor, constant: 8),
            mood4Label.centerXAnchor.constraint(equalTo: mood4Button.centerXAnchor),
            check4Image.centerXAnchor.constraint(equalTo: mood4Button.centerXAnchor, constant: 17),
            check4Image.centerYAnchor.constraint(equalTo: mood4Button.centerYAnchor, constant: -17)
        ])
    }
    
    private func setMood5Constraint() {
        NSLayoutConstraint.activate([
            mood5Button.topAnchor.constraint(equalTo: mood2Label.bottomAnchor, constant: 16),
            mood5Button.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: -47),
            mood5Button.heightAnchor.constraint(equalToConstant: 52),
            mood5Button.widthAnchor.constraint(equalToConstant: 52),
            mood5Label.topAnchor.constraint(equalTo: mood5Button.bottomAnchor, constant: 8),
            mood5Label.centerXAnchor.constraint(equalTo: mood5Button.centerXAnchor),
            check5Image.centerXAnchor.constraint(equalTo: mood5Button.centerXAnchor, constant: 17),
            check5Image.centerYAnchor.constraint(equalTo: mood5Button.centerYAnchor, constant: -17)
        ])
    }
    
    private func setMood6Constraint() {
        NSLayoutConstraint.activate([
            mood6Button.topAnchor.constraint(equalTo: mood2Label.bottomAnchor, constant: 16),
            mood6Button.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: 47),
            mood6Button.heightAnchor.constraint(equalToConstant: 52),
            mood6Button.widthAnchor.constraint(equalToConstant: 52),
            mood6Label.topAnchor.constraint(equalTo: mood6Button.bottomAnchor, constant: 8),
            mood6Label.centerXAnchor.constraint(equalTo: mood6Button.centerXAnchor),
            check6Image.centerXAnchor.constraint(equalTo: mood6Button.centerXAnchor, constant: 17),
            check6Image.centerYAnchor.constraint(equalTo: mood6Button.centerYAnchor, constant: -17)
        ])
    }
    
    @objc func onTapMood1() {
        if mood1 == 0 {
            mood1Button.layer.borderWidth = 1
            check1Image.isHidden = false
            selectedMood = moods[0]
            mood1 += 1
            resetMood2()
            resetMood3()
            resetMood4()
            resetMood5()
            resetMood6()
        } else {
            mood1Button.layer.borderWidth = 0
            check1Image.isHidden = true
            selectedMood = ""
            mood1 -= 1
        }
        print("mood1: \(mood1)")
    }
    
    @objc func onTapMood2() {
        if mood2 == 0 {
            mood2Button.layer.borderWidth = 1
            check2Image.isHidden = false
            selectedMood = moods[1]
            mood2 += 1
            resetMood1()
            resetMood3()
            resetMood4()
            resetMood5()
            resetMood6()
        } else {
            mood2Button.layer.borderWidth = 0
            check2Image.isHidden = true
            selectedMood = ""
            mood2 -= 1
        }
        print("mood2: \(mood2)")
    }
    
    @objc func onTapMood3() {
        if mood3 == 0 {
            mood3Button.layer.borderWidth = 1
            check3Image.isHidden = false
            selectedMood = moods[2]
            mood3 += 1
            resetMood1()
            resetMood2()
            resetMood4()
            resetMood5()
            resetMood6()
        } else {
            mood3Button.layer.borderWidth = 0
            check3Image.isHidden = true
            selectedMood = ""
            mood3 -= 1
        }
        print("mood3: \(mood3)")
    }
    
    @objc func onTapMood4() {
        if mood4 == 0 {
            mood4Button.layer.borderWidth = 1
            check4Image.isHidden = false
            selectedMood = moods[3]
            mood4 += 1
            resetMood1()
            resetMood2()
            resetMood3()
            resetMood5()
            resetMood6()
        } else {
            mood4Button.layer.borderWidth = 0
            check4Image.isHidden = true
            selectedMood = ""
            mood4 -= 1
        }
        print("mood4: \(mood4)")
    }
    
    @objc func onTapMood5() {
        if mood5 == 0 {
            mood5Button.layer.borderWidth = 1
            check5Image.isHidden = false
            selectedMood = moods[4]
            mood5 += 1
            resetMood1()
            resetMood2()
            resetMood3()
            resetMood4()
            resetMood6()
        } else {
            mood5Button.layer.borderWidth = 0
            check5Image.isHidden = true
            selectedMood = ""
            mood2 -= 1
        }
        print("mood5: \(mood5)")
    }
    
    @objc func onTapMood6() {
        if mood6 == 0 {
            mood6Button.layer.borderWidth = 1
            check6Image.isHidden = false
            selectedMood = moods[5]
            mood6 += 1
            resetMood1()
            resetMood2()
            resetMood3()
            resetMood4()
            resetMood5()
        } else {
            mood6Button.layer.borderWidth = 0
            check6Image.isHidden = true
            selectedMood = ""
            mood6 -= 1
        }
        print("mood6: \(mood6)")
    }
    
    func resetMood1() {
        mood1Button.layer.borderWidth = 0
        check1Image.isHidden = true
        mood1 = 0
    }
    
    func resetMood2() {
        mood2Button.layer.borderWidth = 0
        check2Image.isHidden = true
        mood2 = 0
    }
    
    func resetMood3() {
        mood3Button.layer.borderWidth = 0
        check3Image.isHidden = true
        mood3 = 0
    }
    
    func resetMood4() {
        mood4Button.layer.borderWidth = 0
        check4Image.isHidden = true
        mood4 = 0
    }
    
    func resetMood5() {
        mood5Button.layer.borderWidth = 0
        check5Image.isHidden = true
        mood5 = 0
    }
    
    func resetMood6() {
        mood6Button.layer.borderWidth = 0
        check6Image.isHidden = true
        mood6 = 0
    }
    
    @objc func onTapSave() {
        if (PRTextView.text != "Contoh: Saya menjadi lebih tenang setelah saya membuka perasaan saya.") && (selectedMood != "") {
//            UserProfile.shared.PostReflection = PRTextView.text
//            UserProfile.shared.moods = selectedMood.text
            present(ChatListVC(), animated: true)
            
        }
    }
    
    func setupKeyboard(){
          NotificationCenter.default.addObserver(self, selector: #selector(PostReflectionVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(PostReflectionVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
          self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension PostReflectionVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if PRTextView.text == "Contoh: Saya menjadi lebih tenang setelah saya membuka perasaan saya." {
            PRTextView.text = ""
            PRTextView.font = .poppinsRegular(size: 16)
            PRTextView.textColor = .blackPurple
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if PRTextView.text == ""{
            PRTextView.text = "Contoh: Saya menjadi lebih tenang setelah saya membuka perasaan saya."
            PRTextView.font = .poppinsRegular(size: 16)
            PRTextView.textColor = .greyPlaceholder
            countLabel.text = "0/150"
       }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if PRTextView.text == "Contoh: Saya menjadi lebih tenang setelah saya membuka perasaan saya." {
            self.countLabel.text = "0/150"
        } else {
            let strLength = textView.text?.count ?? 0
            self.countLabel.text = "\(strLength)/150"
        }
    }
}
