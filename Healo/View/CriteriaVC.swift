//
//  CriteriaVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CriteriaVC: UIViewController {
    private var viewModel = CriteriaVM()
    let screenSize: CGRect = UIScreen.main.bounds
    
    let disposeBag = DisposeBag()
    var selectedUsia: String = ""
    var selectedGender: String = ""
    var selectedTopic: String = ""
    
    var minUsia: Int = 0
    var maxUsia: Int = 0
    
    let navBar : UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "")
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setTitle("  Kembali", for: .normal)
        backButton.tintColor = .darkPurple
        backButton.setTitleColor(.darkPurple, for: .normal)
        backButton.titleLabel?.font = .poppinsMedium(size: 14)
        let backBtn = UIImage(systemName: "chevron.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))
        backButton.setImage(backBtn, for: .normal)
        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navBar.setItems([navItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.barTintColor = .white
        navBar.shadowImage = UIImage()
        return navBar
    }()
    
    private lazy var title1: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "Pilih Kriteria"
        return label
    }()
    
    private lazy var body1: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .greyPurple
        label.textAlignment = .left
        label.text = "Apakah Anda memiliki preferensi \nListener yang ingin Anda dapatkan?"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var label1Stack = UIStackView()
    
    lazy var rentangField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .lightPurple
        field.layer.cornerRadius = 10
        field.textColor = .greyPurple
        field.text = ("    "+"Rentang Usia")
        field.textAlignment = .left
        field.font = .poppinsRegular(size: 14)
        field.tintColor = .greyPurple
        field.delegate = self

        field.inputView = rentangUsiaPicker
        field.addDoneButtonOnKeyboard()

        return field
    }()
    
    lazy var rentangUsiaPicker : UIPickerView = {
           let picker = UIPickerView()
           picker.backgroundColor = UIColor.pickerBack
           picker.setValue(UIColor.blackPurple, forKey: "textColor")
           picker.frame = CGRect.init(x: 0.0, y: screenSize.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           picker.contentMode = .center
           picker.layer.borderColor = UIColor.pickerBorder.cgColor
           picker.layer.borderWidth = 1
           return picker
    }()
    
    let circleImage = UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
    let circleFillImage = UIImage(systemName: "checkmark.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
    
    lazy var wanitaBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightPurple
        button.layer.cornerRadius = 10
        button.setTitle("    "+"Wanita"+"        ", for: .normal)
        button.setTitleColor(.greyPurple, for: .normal)
        button.titleLabel?.font = .poppinsRegular(size: 14)
        button.tintColor = .greyPurple
        button.semanticContentAttribute = .forceLeftToRight
        button.setImage(circleImage, for: .normal)
        button.addTarget(self, action: #selector(tapWanita), for: .touchUpInside)
        return button
    }()
    
    lazy var priaBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightPurple
        button.layer.cornerRadius = 10
        button.setTitle("    "+"Pria"+"          ", for: .normal)
        button.setTitleColor(.greyPurple, for: .normal)
        button.titleLabel?.font = .poppinsRegular(size: 14)
        button.tintColor = .greyPurple
        button.semanticContentAttribute = .forceLeftToRight
        button.setImage(circleImage, for: .normal)
        button.addTarget(self, action: #selector(tapPria), for: .touchUpInside)
        return button
    }()
    
    private lazy var jenisKelaminStack = UIStackView()
    
    private lazy var title2: UILabel = {
        let label = UILabel()
        label.font = .poppinsSemiBold(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "Topik"
        return label
    }()
    
    private lazy var body2: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .greyPurple
        label.textAlignment = .left
        label.text = "Apa yang membuat kamu mencari \nListener pada hari ini?"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var label2Stack = UIStackView()
    
    lazy var topicField: UITextView = {
        let tview = UITextView()
        tview.backgroundColor = .clear
        tview.layer.cornerRadius = 15
        tview.layer.borderWidth = 1
        tview.font = .poppinsRegular(size: 16)
        tview.layer.borderColor = UIColor.blackPurple.cgColor
        tview.textColor = .tabBarGreyPurple
        tview.textAlignment = .left
        tview.font = .poppinsRegular(size: 14)
        tview.addDoneButtonOnKeyboard()
        tview.textContainer.lineBreakMode = .byWordWrapping
        tview.textContainerInset = UIEdgeInsets(top: 25, left: 16, bottom: 25, right: 16)
        tview.textContainer.lineFragmentPadding = 10
        tview.delegate = self
        return tview
    }()
    

    private lazy var cariButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkPurple
        button.layer.cornerRadius = 10
        button.alpha = 0.4
        button.isEnabled = false
        button.setTitle("Cari Listener", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 16)
        button.addTarget(self, action: #selector(tapCariListener), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
 
    func configureUI(){
        setupView()
        setupLayout()
        setupData()
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(navBar)
    
        label1Stack = UIStackView(arrangedSubviews: [title1, body1])
        label1Stack.axis = .vertical
        label1Stack.spacing = 13
        view.addSubview(label1Stack)
        view.addSubview(rentangField)
        
        jenisKelaminStack = UIStackView(arrangedSubviews: [wanitaBtn, priaBtn])
        jenisKelaminStack.axis = .horizontal
        jenisKelaminStack.spacing = 10
        view.addSubview(jenisKelaminStack)
    
        label2Stack = UIStackView(arrangedSubviews: [title2, body2])
        label2Stack.axis = .vertical
        label2Stack.spacing = 13
        view.addSubview(label2Stack)
        view.addSubview(topicField)
        view.addSubview(cariButton)
    }
    
    
    func setupLayout(){
        setNavBarLay()
        setLabel1StackLay()
        setThreeStackLay()
        setLabel2StackLay()
        setTopicFieldLay()
        setCariBtnLay()
    }
    
    func setNavBarLay(){
        navBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(self.view.frame.height > 735 ? 60 : 40)
            make.width.equalTo(screenSize.width)
            make.height.equalTo(44)
        }
    }
    
    func setLabel1StackLay(){
        label1Stack.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(self.view.frame.height > 735 ? 32 : 10)
            make.left.equalToSuperview().offset(36)
        }
    }
    
    
    func setThreeStackLay(){
        rentangField.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(316)
        }
        
        wanitaBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(152)
        }
        
        priaBtn.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(152)
        }
        
        rentangField.snp.makeConstraints { make in
            make.top.equalTo(label1Stack.snp.bottom).offset(self.view.frame.height > 735 ? 24 : 10)
            make.centerX.equalToSuperview()
        }
        
        jenisKelaminStack.snp.makeConstraints { make in
            make.top.equalTo(rentangField.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func setLabel2StackLay(){
        label2Stack.snp.makeConstraints { make in
            make.top.equalTo(jenisKelaminStack.snp.bottom).offset(self.view.frame.height > 735 ? 32 : 10)
            make.left.equalToSuperview().offset(36)
        }
    }
    
    func setTopicFieldLay(){
        topicField.snp.makeConstraints { make in
            make.top.equalTo(label2Stack.snp.bottom).offset(self.view.frame.height > 735 ? 24 : 10)
            make.centerX.equalToSuperview()
            make.height.equalTo(176)
            make.width.equalTo(323)
        }
    }
    
    func setCariBtnLay(){
        cariButton.snp.makeConstraints { make in
            make.top.equalTo(topicField.snp.bottom).offset(self.view.frame.height > 735 ? 57 : 20)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.width.equalTo(314)
        }
    }
    
    
    func setupData(){
        setupPicker()
        setupField()
    }
    
    func setupPicker(){
        viewModel.setupUsiaPicker()
        bindPicker()
        selectPicker()
    }
    
    func bindPicker(){
        Observable.just(viewModel.usiaList)
            .bind(to: rentangUsiaPicker.rx.itemTitles) { _, item in
                return "\(item)"
            }
          .disposed(by: disposeBag)
    }
    
    func selectPicker(){
       rentangUsiaPicker.rx.itemSelected.asObservable().subscribe(onNext: {item in
           self.selectedUsia = self.viewModel.usiaList[item.row]
    
            if(self.selectedUsia == self.viewModel.usiaList[0]){
                self.selectedUsia = ""
                self.rentangField.text =  "    "+"Rentang Usia"
                self.rentangField.textColor = .greyPurple
                
            } else {
                self.rentangField.text = "    " + "\(self.selectedUsia)"
                self.rentangField.textColor = .blackPurple
            }
        
           switch self.selectedUsia {
            case "17 Tahun - 22 Tahun":
               self.minUsia = 17
               self.maxUsia = 22
            case "23 Tahun - 28 Tahun":
               self.minUsia = 23
               self.maxUsia = 28
           case "29 Tahun - 35 Tahun":
               self.minUsia = 29
               self.maxUsia = 35
           case "36 Tahun - 40 Tahun":
               self.minUsia = 36
               self.maxUsia = 40
           case ">50 tahun":
               self.minUsia = 51
               self.maxUsia = 0
           default:
               ""
           }
           
            self.validateAll()

         }).disposed(by: disposeBag)
    }
    
    
    func setupField(){
        if topicField.text.isEmpty {
            topicField.text =  "Contoh: Hari ini saya merasa \ninsecure karena suatu hal yang \ndikatakan oleh orang tua saya."
            topicField.font = .poppinsRegular(size: 16)
            topicField.textColor = .tabBarGreyPurple
        } else {
            topicField.textColor = .blackPurple
            topicField.font = .poppinsRegular(size: 16)
        }
        
        validateAll()
    }
    
    func setupKeyboard(){
          NotificationCenter.default.addObserver(self, selector: #selector(CriteriaVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(CriteriaVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func validateAll(){
        if (selectedUsia != "" && selectedGender != "" && topicField.text != "Contoh: Hari ini saya merasa \ninsecure karena suatu hal yang \ndikatakan oleh orang tua saya." && topicField.text != "" && topicField.text.isEmpty == false){
            cariButton.alpha = 1
            cariButton.isEnabled = true
        } else {
            cariButton.alpha = 0.4
            cariButton.isEnabled = false
        }
    }
    

    @objc fileprivate func backTapped(){
        let svc = SeekerTabBarVC()
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: false, completion: nil)

    }
    
    @objc func tapWanita(){
        wanitaBtn.tintColor = .white
        wanitaBtn.setImage(circleFillImage, for: .normal)
        wanitaBtn.backgroundColor = .darkPurple
        wanitaBtn.setTitleColor(.white, for: .normal)
        
        priaBtn.tintColor = .greyPurple
        priaBtn.setImage(circleImage, for: .normal)
        priaBtn.backgroundColor = .lightPurple
        priaBtn.setTitleColor(.greyPurple, for: .normal)
        
        selectedGender = "F"
    
        validateAll()
    }
    
    @objc func tapPria(){
        priaBtn.tintColor = .white
        priaBtn.setImage(circleFillImage, for: .normal)
        priaBtn.backgroundColor = .darkPurple
        priaBtn.setTitleColor(.white, for: .normal)
        
        wanitaBtn.tintColor = .greyPurple
        wanitaBtn.setImage(circleImage, for: .normal)
        wanitaBtn.backgroundColor = .lightPurple
        wanitaBtn.setTitleColor(.greyPurple, for: .normal)
        
        selectedGender = "M"
       
        validateAll()
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
    
    @objc func tapCariListener(){
        selectedTopic = topicField.text
        
        print("CARI LISTENER NOW")
        print(selectedGender)
        print(selectedUsia)
        print(minUsia)
        print(maxUsia)
        print(selectedTopic)
        SocketHandler.shared.findHealer(myStruct: [String].self, minAge: minUsia, maxAge: maxUsia, preferGender: selectedGender, preflek: selectedGender)
        let plvc = PairingLoadingVC()
        plvc.modalPresentationStyle = .fullScreen
        present(plvc, animated: false, completion: nil)
    }
    
}
