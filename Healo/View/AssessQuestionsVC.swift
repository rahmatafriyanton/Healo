//
//  AssessQuestionsVC.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 15/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class AssessQuestionsVC: UIViewController {
    var currentQuestionNum: Int = 0
    var assessQuestions: [AssQuestion] = []
    var currentQuestion: AssQuestion?
    var selectedAnswers: [QuestionAnswer] = []
    var currentAnswer: Int = 1
    
    let disposeBag = DisposeBag()
    
    // elvina, ini apus aja klo mau wkwk
    private lazy var labelNgetes: UILabel = {
        let view = UILabel()
        view.text = ""
        view.numberOfLines = 0
        view.textColor = .blackPurple
        view.textAlignment = .left
        return view
    }()
    
    private lazy var nextButton: ReusableNextButton = {
        let view = ReusableNextButton(text: "Berikutnya")
        view.addTarget(self, action: #selector(clickNext), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        AssessQuestionsVM.shared.assQuestions.subscribe(onNext: { [self] event in
            assessQuestions = event
        }).disposed(by: disposeBag)
        AssessQuestionsVM.shared.currassQuestions.subscribe(onNext: { [self] event in
            currentQuestion = event
        }).disposed(by: disposeBag)
        
        // elvina ini bole diapus klo ga perlu
        setupLabel()
        configureUI()
    }
    
    func setupLabel() {
        labelNgetes.text = assessQuestions[currentQuestionNum].description
    }
    
    @objc func clickNext() {
        // append
        currentQuestionNum += 1
        var answer = QuestionAnswer(question_id: currentQuestionNum, answer_id: currentAnswer)
        selectedAnswers.append(answer)
        if(currentQuestionNum < 14){
            AssessQuestionsVM.shared.currassQuestions.onNext(assessQuestions[currentQuestionNum])
            setupLabel()
        } else {
            currentQuestionNum = 0
            AssessmentResultVM.shared.makeAssessment(myStruct: AssResult.self, answers: selectedAnswers)
            navigationController?.pushViewController(HasilAssessVC(), animated: true)
        }
    }
    
    func configureUI() {
        view.addSubview(labelNgetes)
        labelNgetes.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.right.equalToSuperview().inset(26)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(52)
        }
    }

}
