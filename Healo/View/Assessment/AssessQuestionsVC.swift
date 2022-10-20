//
//  AssessQuestionsVC.swift
//  Healo
//
//  Created by Elvina Jacia on 15/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

var questionNum = 0
var initialLoad = true

var currentQuestionNum: Int = 0
var assessQuestions: [AssQuestion] = []
var currentQuestion: AssQuestion?
var selectedAnswers: [QuestionAnswer] = []
var currentAnswer: Int = 1
    
let disposeBag = DisposeBag()

class  AssessQuestionsVC: UIViewController, UIScrollViewDelegate {

    lazy var chosenAnswer = 0
    lazy var hasSelected = false
    
    private var shouldCollapse = false

    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.delegate = self
        return scroll
    }()
    
    private lazy var stripe1: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe3: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe4: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe5: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe6: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()

    private lazy var stripe7: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe8: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe9: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe10: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe11: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe12: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe13: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripe14: UIView = {
        let view = UIView()
        view.backgroundColor = .lightPurple
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var stripeStack = UIStackView()
    
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var questNum: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    private lazy var totalQuest: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .greyPurple
        label.textAlignment = .center
        label.text = " dari 14"
        return label
    }()
    
    private lazy var numOfQuestStack = UIStackView()
    
    private lazy var topicTitle: UILabel = {
        let label = UILabel()
        label.font = .poppinsBold(size: 18)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var topicDesc: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var longStripe: UIView = {
        let view = UIView()
        view.backgroundColor = .darkPurple
        return view
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blackPurple
        label.font = .poppinsRegular(size: 16)
        return label
    }()
    
    let circleFillImage = UIImage(systemName: "checkmark.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .thin))
    let circleImage = UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .thin))

    
    private lazy var ans1BtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.borderWidth = 0.7
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFit
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapAns1Action))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var leftView1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var circleImgView1 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = circleImage
        imageView.tintColor = .darkPurple
        return imageView
    }()
    
    private lazy var ansLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blackPurple
        label.font = .poppinsRegular(size: 16)
        return label
    }()

    private lazy var ans1Stack = UIStackView()
    
    
    private lazy var ans2BtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.borderWidth = 0.7
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFit
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapAns2Action))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var leftView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var circleImgView2 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = circleImage
        imageView.tintColor = .darkPurple
        return imageView
    }()
    
    private lazy var ansLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blackPurple
        label.font = .poppinsRegular(size: 16)
        return label
    }()

    private lazy var ans2Stack = UIStackView()
    
    private lazy var ans3BtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.darkPurple.cgColor
        view.layer.borderWidth = 0.7
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFit
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapAns3Action))
        view.addGestureRecognizer(tapGR)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var leftView3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var circleImgView3 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = circleImage
        imageView.tintColor = .darkPurple
        return imageView
    }()
    
    private lazy var ansLabel3: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .blackPurple
        label.font = .poppinsRegular(size: 16)
        return label
    }()

    private lazy var ans3Stack = UIStackView()
    
    private lazy var berikutnyaButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkPurple
        button.alpha = 0.4
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.setTitle("Berikutnya", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 16)
        button.addTarget(self, action: #selector(tapBerikutnyaAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupProgressBar()
        configureUI()
    }
    
    func setupData(){
        if initialLoad == true {
            questionNum = 1
            initialLoad = false
            AssessQuestionsVM.shared.assQuestions.subscribe(onNext: { event in
                assessQuestions = event
            }).disposed(by: disposeBag)
            AssessQuestionsVM.shared.currassQuestions.subscribe(onNext: { event in
                currentQuestion = event
            }).disposed(by: disposeBag)
        }
        
        questNum.text = String(questionNum)
        topicTitle.text = assessQuestions[currentQuestionNum].title
        topicDesc.text = assessQuestions[currentQuestionNum].description
        questionLabel.text = assessQuestions[currentQuestionNum].question
        ansLabel1.text = assessQuestions[currentQuestionNum].answers[0].answer
        ansLabel2.text =  assessQuestions[currentQuestionNum].answers[1].answer
        ansLabel3.text =  assessQuestions[currentQuestionNum].answers[2].answer
        
    }
    
    func setupProgressBar(){
        if questionNum == 1 {
            stripe1.backgroundColor = .darkPurple
        } else if questionNum == 2 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
        }  else if questionNum == 3 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
        }  else if questionNum == 4 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
        }  else if questionNum == 5 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
        }  else if questionNum == 6 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
        }  else if questionNum == 7 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
        }  else if questionNum == 8 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
        }  else if questionNum == 9 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
            stripe9.backgroundColor = .darkPurple
        }  else if questionNum == 10 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
            stripe9.backgroundColor = .darkPurple
            stripe10.backgroundColor = .darkPurple
        }  else if questionNum == 11 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
            stripe9.backgroundColor = .darkPurple
            stripe10.backgroundColor = .darkPurple
            stripe11.backgroundColor = .darkPurple
        }  else if questionNum == 12 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
            stripe9.backgroundColor = .darkPurple
            stripe10.backgroundColor = .darkPurple
            stripe11.backgroundColor = .darkPurple
            stripe12.backgroundColor = .darkPurple
        }  else if questionNum == 13 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
            stripe9.backgroundColor = .darkPurple
            stripe10.backgroundColor = .darkPurple
            stripe11.backgroundColor = .darkPurple
            stripe12.backgroundColor = .darkPurple
            stripe13.backgroundColor = .darkPurple
        }  else if questionNum == 14 {
            stripe1.backgroundColor = .darkPurple
            stripe2.backgroundColor = .darkPurple
            stripe3.backgroundColor = .darkPurple
            stripe4.backgroundColor = .darkPurple
            stripe5.backgroundColor = .darkPurple
            stripe6.backgroundColor = .darkPurple
            stripe7.backgroundColor = .darkPurple
            stripe8.backgroundColor = .darkPurple
            stripe9.backgroundColor = .darkPurple
            stripe10.backgroundColor = .darkPurple
            stripe11.backgroundColor = .darkPurple
            stripe12.backgroundColor = .darkPurple
            stripe13.backgroundColor = .darkPurple
            stripe14.backgroundColor = .darkPurple
        }
        
    }
    
    func configureUI(){
        setupView()
        setupLayout()
    }

    func setupView(){
        view.backgroundColor = .white
        
        stripeStack = UIStackView(arrangedSubviews: [stripe1, stripe2, stripe3, stripe4, stripe5, stripe6, stripe7, stripe8, stripe9, stripe10, stripe11, stripe12, stripe13, stripe14])
        stripeStack.axis = .horizontal
        stripeStack.spacing = 0.5
        baseView.addSubview(stripeStack)

    
        numOfQuestStack = UIStackView(arrangedSubviews: [questNum, totalQuest])
        numOfQuestStack.axis = .horizontal
        numOfQuestStack.spacing = 1
        baseView.addSubview(numOfQuestStack)

        baseView.addSubview(topicTitle)
        
        baseView.addSubview(topicDesc)
        baseView.addSubview(longStripe)
        
        baseView.addSubview(questionLabel)
        
        leftView1.addSubview(circleImgView1)
        ans1Stack = UIStackView(arrangedSubviews: [leftView1, ansLabel1])
        ans1Stack.axis = .horizontal
        ans1Stack.spacing = 16
        ans1BtnView.addSubview(ans1Stack)
        
        baseView.addSubview(ans1BtnView)
        
        leftView2.addSubview(circleImgView2)
        ans2Stack = UIStackView(arrangedSubviews: [leftView2, ansLabel2])
        ans2Stack.axis = .horizontal
        ans2Stack.spacing = 16
        ans2BtnView.addSubview(ans2Stack)
        
        baseView.addSubview(ans2BtnView)
        
        leftView3.addSubview(circleImgView3)
        ans3Stack = UIStackView(arrangedSubviews: [leftView3, ansLabel3])
        ans3Stack.axis = .horizontal
        ans3Stack.spacing = 16
        ans3BtnView.addSubview(ans3Stack)
        
        baseView.addSubview(ans3BtnView)
        
        baseView.addSubview(berikutnyaButton)
        
        scrollView.addSubview(baseView)
        view.addSubview(scrollView)
    }
    
    func setupLayout(){
        setupScrollView()
        setupBaseView()
        
        setupStripeStack()
        setupNumQuestStack()
        setupQuestTitleStack()
        setupTopicDesc()
        setupLongStripe()
        setupQuestion()
        setupAns1()
        setupAns2()
        setupAns3()
        setupBerikutnya()
    }
    
    func setupScrollView(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupBaseView(){
        baseView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self.view)
        }
    }
    
    
    func setupStripeStack(){
        
        stripe1.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe2.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe3.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe4.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe5.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe6.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe7.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe8.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe9.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }

        stripe10.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe11.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe12.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe13.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        stripe14.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(24)
        }
        
        
        stripeStack.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.top).offset(62)
            make.centerX.equalTo(baseView.snp.centerX)
        }
    }
    
    func setupNumQuestStack(){
        numOfQuestStack.snp.makeConstraints { make in
            make.top.equalTo(stripeStack.snp.bottom).offset(21)
            make.left.equalTo(baseView.snp.left).offset(27)
        }
    }
    
    func setupQuestTitleStack(){
        topicTitle.snp.makeConstraints { make in
            make.top.equalTo(numOfQuestStack.snp.bottom).offset(21)
            make.left.equalTo(baseView.snp.left).offset(27)
        }
    }

    func setupTopicDesc(){
        topicDesc.snp.makeConstraints { make in
            make.top.equalTo(topicTitle.snp.bottom).offset(21)
            make.left.equalTo(baseView.snp.left).offset(27)
            make.right.equalTo(baseView.snp.right).offset(-27)
        }
    }
    
    func setupLongStripe(){
        longStripe.snp.makeConstraints { make in
            make.top.equalTo(topicDesc.snp.bottom).offset(21)
            make.left.equalTo(baseView.snp.left).offset(27)
            make.right.equalTo(baseView.snp.right).offset(-27)
            make.height.equalTo(1)
        }
    }
    
    func setupQuestion(){
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(longStripe.snp.bottom).offset(16)
            make.left.equalTo(baseView.snp.left).offset(26)
            make.right.equalTo(baseView.snp.right).offset(26)
            make.centerX.equalTo(baseView.snp.centerX)
        }
    }
    
    func setupAns1(){
        leftView1.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        
        circleImgView1.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.centerX.centerY.equalTo(leftView1)
        }
        
        ans1Stack.snp.makeConstraints { make in
            make.centerX.equalTo(ans1BtnView)
            make.left.equalTo(ans1BtnView).offset(16)
            make.right.equalTo(ans1BtnView).offset(-16)
            make.top.equalTo(ans1BtnView).offset(10)
            make.bottom.equalTo(ans1BtnView).offset(10)
        }
        
        ans1BtnView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
            make.left.equalTo(baseView.snp.left).offset(31)
            make.right.equalTo(baseView.snp.right).offset(-31)
            make.centerX.equalTo(baseView.snp.centerX)
            make.height.equalTo(ans1Stack.snp.height).offset(20)
        }
    }
    
    func setupAns2(){
        leftView2.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        
        circleImgView2.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.centerX.centerY.equalTo(leftView2)
        }
        
        ans2Stack.snp.makeConstraints { make in
            make.centerX.equalTo(ans2BtnView)
            make.left.equalTo(ans2BtnView).offset(16)
            make.right.equalTo(ans2BtnView).offset(-16)
            make.top.equalTo(ans2BtnView).offset(10)
            make.bottom.equalTo(ans2BtnView).offset(10)
        }
        
        ans2BtnView.snp.makeConstraints { make in
            make.top.equalTo(ans1BtnView.snp.bottom).offset(8)
            make.left.equalTo(baseView.snp.left).offset(31)
            make.right.equalTo(baseView.snp.right).offset(-31)
            make.centerX.equalTo(baseView.snp.centerX)
            make.height.equalTo(ans2Stack.snp.height).offset(20)
        }
        
    }
    
    func setupAns3(){
        leftView3.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        
        circleImgView3.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.centerX.centerY.equalTo(leftView3)
        }
        
        ans3Stack.snp.makeConstraints { make in
            make.centerX.equalTo(ans3BtnView)
            make.left.equalTo(ans3BtnView).offset(16)
            make.right.equalTo(ans3BtnView).offset(-16)
            make.top.equalTo(ans3BtnView).offset(10)
            make.bottom.equalTo(ans3BtnView).offset(10)
        }
        
        ans3BtnView.snp.makeConstraints { make in
            make.top.equalTo(ans2BtnView.snp.bottom).offset(8)
            make.left.equalTo(baseView.snp.left).offset(31)
            make.right.equalTo(baseView.snp.right).offset(-31)
            make.centerX.equalTo(baseView.snp.centerX)
            make.height.equalTo(ans3Stack.snp.height).offset(20)
        }
        
    }
    
    func setupBerikutnya(){
        berikutnyaButton.snp.makeConstraints { make in
            make.top.equalTo(ans3BtnView.snp.bottom).offset(46)
            make.centerX.equalTo(baseView.snp.centerX)
            make.width.equalTo(314)
            make.height.equalTo(52)
            make.bottom.equalTo(baseView.snp.bottom).offset(-80)
        }
    }
    
    
    @objc func tapAns1Action(){
        ans1BtnView.backgroundColor = .darkPurple
        circleImgView1.image = circleFillImage
        circleImgView1.tintColor = .white
        ansLabel1.textColor = .white
        
        ans2BtnView.backgroundColor = .white
        ans2BtnView.layer.borderWidth = 0.7
        ans2BtnView.layer.borderColor = UIColor.darkPurple.cgColor
        circleImgView2.image = circleImage
        circleImgView2.tintColor = .darkPurple
        ansLabel2.textColor = .blackPurple
        
        ans3BtnView.backgroundColor = .white
        ans3BtnView.layer.borderWidth = 0.7
        ans3BtnView.layer.borderColor = UIColor.darkPurple.cgColor
        circleImgView3.image = circleImage
        circleImgView3.tintColor = .darkPurple
        ansLabel3.textColor = .blackPurple
        
        chosenAnswer = 1
        validateBerikutnya()
        
    }
    
    @objc func tapAns2Action(){
        ans2BtnView.backgroundColor = .darkPurple
        circleImgView2.image = circleFillImage
        circleImgView2.tintColor = .white
        ansLabel2.textColor = .white
        
        ans1BtnView.backgroundColor = .white
        ans1BtnView.layer.borderWidth = 0.7
        ans1BtnView.layer.borderColor = UIColor.darkPurple.cgColor
        circleImgView1.image = circleImage
        circleImgView1.tintColor = .darkPurple
        ansLabel1.textColor = .blackPurple
        
        ans3BtnView.backgroundColor = .white
        ans3BtnView.layer.borderWidth = 0.7
        ans3BtnView.layer.borderColor = UIColor.darkPurple.cgColor
        circleImgView3.image = circleImage
        circleImgView3.tintColor = .darkPurple
        ansLabel3.textColor = .blackPurple
        
        chosenAnswer = 2
        validateBerikutnya()
    }
    
    @objc func tapAns3Action(){
        ans3BtnView.backgroundColor = .darkPurple
        circleImgView3.image = circleFillImage
        circleImgView3.tintColor = .white

        ansLabel3.textColor = .white
        
        ans1BtnView.backgroundColor = .white
        ans1BtnView.layer.borderWidth = 0.7
        ans1BtnView.layer.borderColor = UIColor.darkPurple.cgColor
        circleImgView1.image = circleImage
        circleImgView1.tintColor = .darkPurple
        ansLabel1.textColor = .blackPurple
        
        ans2BtnView.backgroundColor = .white
        ans2BtnView.layer.borderWidth = 0.7
        ans2BtnView.layer.borderColor = UIColor.darkPurple.cgColor
        circleImgView2.image = circleImage
        circleImgView2.tintColor = .darkPurple
        ansLabel2.textColor = .blackPurple
        
        chosenAnswer = 3
        validateBerikutnya()
    }
    
    @objc func tapBerikutnyaAction(){
        print("Chosen answer: \(chosenAnswer)" )
      
        questionNum += 1
        
        print("Ke Soal Berikutnya \(questionNum)")
        
        currentQuestionNum += 1
        var answer = QuestionAnswer(question_id: currentQuestionNum, answer_id: 3*(currentQuestionNum-1)+chosenAnswer)
        selectedAnswers.append(answer)
        print(selectedAnswers)
        
        if questionNum <= 14 {
            AssessQuestionsVM.shared.currassQuestions.onNext(assessQuestions[currentQuestionNum])

            let aqc = AssessQuestionsVC()
            aqc.modalPresentationStyle = .custom
            aqc.modalTransitionStyle = .crossDissolve
            present(aqc, animated: false, completion: nil)
        } else if questionNum > 14 {
            
            currentQuestionNum = 0
            AssessmentResultVM.shared.makeAssessment(myStruct: AssResult.self, answers: selectedAnswers)
            
            //MARK: MOVE TO ASSESSMENT RESULT VC
            let hac = HasilAssessVC()
            hac.modalPresentationStyle = .custom
            hac.modalTransitionStyle = .crossDissolve
            present(hac, animated: false, completion: nil)
            
            print("SUDAH SELESAI 14 NOMOR")
        }
    }
    
    func validateBerikutnya(){
        hasSelected = true
        berikutnyaButton.isEnabled = true
        berikutnyaButton.alpha = 1
    }
    
}
