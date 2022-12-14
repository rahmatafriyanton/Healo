//
//  ChatListVC.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class ChatListVC: UIViewController, UIScrollViewDelegate {
    private var viewModel = ChatListVM()
    private var bag = DisposeBag()
    var timer = Timer()
   
    let screenSize: CGRect = UIScreen.main.bounds
    
    let navBar : UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Chats")
        let atr = [
            NSAttributedString.Key.foregroundColor: UIColor.blackPurple,
            NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 25)!
        ]

        UINavigationBar.appearance().titleTextAttributes = atr
        
        
        navBar.setItems([navItem], animated: false)
        navBar.barTintColor = .lightPurple
        navBar.shadowImage = UIImage()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private lazy var halfView: UIView = {
        let halfView = UIView()
        halfView.backgroundColor = .white
        halfView.translatesAutoresizingMaskIntoConstraints = false
        return halfView
    }()
    
    private lazy var searchListenerBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkPurple
        button.layer.cornerRadius = 15
        button.setTitle(" Cari Listener Baru", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        let searchImage = UIImage(systemName: "magnifyingglass",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))
        button.setImage(searchImage, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapSearchAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var chatTableView: UITableView = {
        let chatTableView = UITableView()
        chatTableView.backgroundColor = .clear
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        chatTableView.separatorStyle = .none
        return chatTableView
    }()
    
    private lazy var noChatImage: UIImageView = {
        let imageView = UIImageView()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .thin, scale: .large)
        imageView.image = UIImage(named: "empty-illus")
        imageView.tintColor = .greyPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var noChatTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .center
        label.text = "Anda belum memiliki chat"
        return label
    }()
    
    private lazy var noChatDescLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .greyPurple
        label.textAlignment = .center
        label.text = "Klik tombol Cari Listener Baru untuk mencari Listener"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var labelStack = UIStackView()
    
    override func viewDidAppear(_ animated: Bool) {
        print("appear")
        SocketHandler.shared.establishConnection()
        SocketHandler.shared.mSocket.on(clientEvent: .connect){data, ack in
            SocketHandler.shared.createConnection(id: UserProfile.shared.userId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        GetUserVM.shared.getUser(myStruct: User.self)
        SocketHandler.shared.establishConnection()
        SocketHandler.shared.mSocket.on(clientEvent: .connect){data, ack in
            SocketHandler.shared.createConnection(id: UserProfile.shared.userId)
            print("socket connected with user id \(UserProfile.shared.userId)")
            print("socket connected with user role \(UserProfile.shared.userRole)")
        }
        configureUI()
        if (UserProfile.shared.userRole == 1){
            searchListenerBtn.isEnabled = false
            searchListenerBtn.layer.opacity = 0
            
            UserProfile.shared.userIsAvailable = 1
            // untuk nerima data
            SocketHandler.shared.listenGotPaired()
            SocketHandler.shared.mSocket.on("got_paired") { [] ( data, ack) -> Void in
                let rvc = RequestAlertVC()
                rvc.modalPresentationStyle = .custom
                rvc.modalTransitionStyle = .crossDissolve
                self.present(rvc, animated: false, completion: nil)
            }
            SocketHandler.shared.mSocket.on("chat_session_created") { ( data, ack) -> Void in
                let roomId = (data[0] as! [String: AnyObject])["room_id"] as! String
                UserProfile.shared.currentRoomId = roomId
                self.navigationController?.pushViewController(ChatVC(with: roomId), animated: false)
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { [] _ in
                print("listener set")
                SocketHandler.shared.addHealerToQueue(isAvailable: UserProfile.shared.userIsAvailable)
            })
        }
    }
    
    func configureUI(){
        setupView()
        setupLayout()
    }
  
    func setupView(){
        view.backgroundColor = .lightPurple
        view.addSubview(navBar)
    
        setRoundedHalfView()
        view.addSubview(halfView)
        
        view.addSubview(searchListenerBtn)
        setTableView()
        halfView.addSubview(chatTableView)
        
        halfView.addSubview(noChatImage)
        labelStack = UIStackView(arrangedSubviews: [noChatTitleLabel, noChatDescLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 10
        halfView.addSubview(labelStack)
    }
    
    func setRoundedHalfView(){
        halfView.clipsToBounds = true
        halfView.layer.cornerRadius = 30
        halfView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setTableView(){
        regisTableViewCell()
        if (UserProfile.shared.userRole == 1){
            viewModel.fetchActiveChats()
        } else if (UserProfile.shared.userRole == 2){
            viewModel.fetchSectionedChats()
        }
     
        if viewModel.totalChat == 0 {
            setNoChat()
        } else {
            setChat()
            bindTableView()
        }
    }
    
    func regisTableViewCell(){
        chatTableView.register(ChatCell.self, forCellReuseIdentifier: "cell")
    }
    
    func bindTableView(){
        chatTableView.rx.setDelegate(self).disposed(by: bag)
        
        let dataSource = RxTableViewSectionedReloadDataSource <SectionModel<String,ChatUser>> { _, chatTableView, indexPath, item in
            
            var badgeLbl : String = ""
            
            if(item.chatStatus == "Past") {
                if(item.reflectStatus == 0) {
                    badgeLbl = "!" + "      "
                }
            } else {
                if(item.numOfMesReceived>0){
                    badgeLbl = "\(item.numOfMesReceived)" + "    "
                }
            }
            
            let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell") as! ChatCell
            cell.usernameLabel.text = item.username
            cell.profileIcon.setImage(from: item.profileIcon)
            cell.messageLabel.text = item.message
            cell.timeLabel.text = item.sentTime
            cell.badgeLabel.text = badgeLbl
            
            if(item.reflectStatus == 1) {
                cell.badgeLabel.isHidden = true
            }
            
            return cell
            
        } titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
        
        _ = chatTableView.rx.delegate.methodInvoked(#selector(chatTableView.delegate?.tableView(_:willDisplayHeaderView:forSection:)))
            .take(until: chatTableView.rx.deallocated)
            .subscribe(onNext: { event in
                guard let headerView = event[1] as? UITableViewHeaderFooterView else { return }
                    
                for view in headerView.subviews {
                    view.backgroundColor = .clear
                }
                        
                headerView.textLabel?.font = .poppinsMedium(size: 18)
                headerView.textLabel?.textColor = .blackPurple
                let separatorLine = UIView(frame: CGRect(x: 0, y: headerView.bounds.height - 1, width: headerView.frame.width, height: 1))
                    separatorLine.backgroundColor = .none
                    headerView.addSubview(separatorLine)
   
                })
    
        
        self.viewModel.chatUsers.bind(to: self.chatTableView.rx.items(dataSource: dataSource)).disposed(by: bag)
      
        
        chatTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("indexPath")
            if(indexPath.section == 0){
                UserProfile.shared.currentRoomId = self.viewModel.activeSection.items[indexPath.row].id
            } else {
                UserProfile.shared.currentRoomId = self.viewModel.pastSection.items[indexPath.row].id
            }
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(ChatVC(with: UserProfile.shared.currentRoomId), animated: false)
            }

        }).disposed(by: bag)
        
    }
    
    func setNoChat(){
        noChatImage.isHidden = false
        noChatTitleLabel.isHidden = false
        noChatDescLabel.isHidden = false
    }
    
    func setChat(){
        noChatImage.isHidden = true
        noChatTitleLabel.isHidden = true
        noChatDescLabel.isHidden = true
    }
    
    func setupLayout(){
        setNavBarLayout()
        setHalfViewLayout()
        setSearchListenerBtnLayout()
        setTableViewLayout()
        setNoChatLayout()
    }
    
    func setNavBarLayout(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 57).isActive = true
        navBar.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setHalfViewLayout(){
        halfView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 51 ).isActive = true
        halfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        halfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        halfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func setSearchListenerBtnLayout(){
        searchListenerBtn.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 25 ).isActive = true
        searchListenerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        searchListenerBtn.widthAnchor.constraint(equalToConstant: 313).isActive = true
        searchListenerBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    func setTableViewLayout(){
        chatTableView.centerXAnchor.constraint(equalTo: halfView.centerXAnchor, constant: 0).isActive = true
        chatTableView.topAnchor.constraint(equalTo: halfView.topAnchor, constant: 30).isActive = true
        chatTableView.widthAnchor.constraint(equalTo: halfView.widthAnchor).isActive = true
        chatTableView.heightAnchor.constraint(equalTo: halfView.heightAnchor).isActive = true
    }
    
    func setNoChatLayout(){
        noChatImage.snp.makeConstraints { make in
            make.centerX.equalTo(halfView.snp.centerX)
            make.centerY.equalTo(halfView.snp.centerY).offset(-70)
            make.width.equalTo(163)
            make.height.equalTo(279)
        }
        
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(noChatImage.snp.bottom).offset(-40)
            make.centerX.equalTo(halfView.snp.centerX)
            make.left.right.equalToSuperview().inset(20)
        }
    }

    @objc fileprivate func tapSearchAction(){
        if viewModel.numOfActiveChat == 0 {
            let cvc = CriteriaVC()
            let navVC = UINavigationController(rootViewController:cvc)
            navVC.isNavigationBarHidden = true
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: false, completion: nil)
        } else {
            let svc = SorryAlertVC()
            svc.modalPresentationStyle = .custom
            svc.modalTransitionStyle = .crossDissolve
            present(svc, animated: false, completion: nil)
            
        }
        
    }


}


