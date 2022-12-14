//
//  ChatVC.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 23/10/22.
//

import UIKit
import SnapKit
import MessageKit
import InputBarAccessoryView
import RxSwift
import RxCocoa

class ChatVC: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate  {
    
    public let currRoomId: String
    private var chatViewModel = ChatVM()
    let bag = DisposeBag()

    // ntar ganti jadi let currentUser = Sender, pass data dari chat list
    var currentUser = Sender(senderId: "self", displayName: "seeker")
    var otherUser = Sender(senderId: "other", displayName: "listener")
    
    var messages = [MessageType]()
    
    var selfImage: UIImage? = nil
    var otherImage: UIImage? = nil
    
    var imageUrl = ""
    var receiverUsername = ""
    var receiverAge = 0
    var receiverGender = ""
    
    var roomStatus = ""
    
    let dateFormatter = DateFormatter()
    
    init (with roomId: String){
        self.currRoomId = roomId
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    public static let idDateFormatter: DateFormatter = {
        let formattre = DateFormatter()
        formattre.dateFormat = "y-MM-dd H:mm:ss.SSSS"
        formattre.locale = .current
        return formattre
    }()
    
    private let msgDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "H:mm"
      return formatter
    }()
    
    private lazy var profileView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightPurple
        return view
    }()
    
    private lazy var whiteView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .darkPurple
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var iconView : UIView = {
        let iconView = UIView()
        iconView.backgroundColor = .clear
        return iconView
    }()
    
    private lazy var iconImgView : UIImageView = {
        let iconView = UIImageView()
        iconView.setImage(from: "\(imageUrl)")
        iconView.clipsToBounds = true
        iconView.layer.borderColor = UIColor.darkPurple.cgColor
        iconView.layer.borderWidth = 1
        iconView.contentMode = .scaleAspectFit
        iconView.layer.cornerRadius = 23
        iconView.backgroundColor = .clear
        return iconView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 21)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "\(receiverUsername)"
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.text = "\(receiverAge) tahun, \(receiverGender)"
        return label
    }()
    
    private lazy var labelStack = UIStackView()
   
    private lazy var profileLabelStack = UIStackView()
    
    private lazy var tripleBtn: UIButton = {
        let button = UIButton()
        button.tintColor = .darkPurple
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tripleTapped), for: .touchUpInside)
        return button
    }()
    
    // insert func socket async, isinya append si chat terakhir

    override func viewDidLoad() {
        super.viewDidLoad()
        print("current room id:")
        print(self.currRoomId)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: .none)
        
        view.backgroundColor = .red
        self.messagesCollectionView.contentInset = UIEdgeInsets(top: self.view.frame.height > 735 ? 180 : 180, left: 0, bottom: 0, right: 0)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        messageInputBar.inputTextView.becomeFirstResponder()
        print("chatvc loaded")
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        chatViewModel.chatDetail.subscribe(onNext: { [self] event in
            roomStatus = event.roomStatus
            if (UserProfile.shared.userRole == 1){
                otherUser = Sender(senderId: "\(event.seeker.userID)", displayName: event.seeker.userName)
                
                imageUrl = event.seeker.profilePict
                receiverUsername = event.seeker.userName
                receiverAge = event.seeker.age
                receiverGender = event.seeker.userGender
            } else if (UserProfile.shared.userRole == 2){
                otherUser = Sender(senderId: "\(event.healer.userID)", displayName: event.healer.userName)
                
                imageUrl = event.healer.profilePict
                receiverUsername = event.healer.userName
                receiverAge = event.healer.age
                receiverGender = event.healer.userGender
            }
            currentUser = Sender(senderId: "\(UserProfile.shared.userId)", displayName: UserProfile.shared.username)
            
            if (event.messages?.isEmpty == false){
                for e in event.messages!.reversed(){
                    if (e.senderID == UserProfile.shared.userId){
                        messages.append(Message(sender: currentUser, messageId: e.messageID, sentDate: dateFormatter.date(from: e.createdAt) ?? Date(), kind: .text(e.message)))
                    } else {
                        print("DATEEE " + e.createdAt)
                        messages.append(Message(sender: otherUser   , messageId: e.messageID, sentDate: dateFormatter.date(from: e.createdAt) ?? Date(), kind: .text(e.message)))
                    }
                }
            }
            
            // simpen image lawan bicara
            guard let urlOtherImage = URL(string: (UserProfile.shared.userRole==1 ? event.seeker.profilePict : event.healer.profilePict)) else {
                print("urlOtherImage error")
                return
            }

            let dataTaskOtherImage = URLSession.shared.dataTask(with: urlOtherImage) { [weak self] (data, _, _) in
                if let data = data {
                    // Create Image and Update Image View
                    print("get image")
                    self?.otherImage = UIImage(data: data)
                }
            }
            dataTaskOtherImage.resume()
            
        }).disposed(by: bag)
        chatViewModel.fetchChats(myStruct: ChatDetail.self, roomId: currRoomId)
        configureUI()
//        currentUser = Sender(senderId: "self", displayName: UserProfile.shared.username)
//        otherUser = Sender(senderId: "other", displayName: UserProfile.shared.username)
//        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("halooo")))
        SocketHandler.shared.mSocket.on("new_message") { ( data, ack) -> Void in
            let message = data[0] as! [String: AnyObject]
            let messageId = message["message_id"] as! String
            let messageText = message["message"] as! String
            let senderId = message["sender_id"] as! Int
            let createdAt = message["createdAt"] as! String
            if (senderId != UserProfile.shared.userId){
                self.messages.append(Message(sender: self.otherUser, messageId: messageId, sentDate: self.dateFormatter.date(from: createdAt) ?? Date(), kind: .text(messageText)))
                self.messagesCollectionView.reloadDataAndKeepOffset()
                self.messagesCollectionView.scrollToLastItem(animated: false)
            }
        }
        
        // listen to room_ended
        SocketHandler.shared.mSocket.on("room_ended") { ( data, ack) -> Void in
            let response = data[0] as! [String: AnyObject]
            let closedBy = response["room_closed_by"] as! Int
            if (closedBy != UserProfile.shared.userId){
                SocketHandler.shared.leaveRoom(roomId: self.currRoomId)
                self.navigationController?.pushViewController(DidEndChatVC(), animated: false)
            }

        }
        
        // simpen image sendiri
        guard let urlSelfImage = URL(string: UserProfile.shared.userProfilePict) else {
            print("urlSelfImage error")
            return
        }

        let dataTaskSelfImage = URLSession.shared.dataTask(with: urlSelfImage) { [weak self] (data, _, _) in
            if let data = data {
                // Create Image and Update Image View
                print("get image")
                self?.selfImage = UIImage(data: data)
            }
        }
        dataTaskSelfImage.resume()
        
        self.messagesCollectionView.reloadDataAndKeepOffset()
        self.messagesCollectionView.scrollToLastItem(animated: false)
    }
    
    func configureUI(){
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(162)
        }
        
//        setupProfileData()
        setupProfileView()
        setupProfileLayout()
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalTo(profileView.snp.bottom)
            make.height.equalTo(40)
        }
        
    }
    
    func setupProfileData(){
        //Get Icon dri db
        receiverUsername = "@johndoe"
        receiverAge = 18
        receiverGender = "pria"
        
    }
    
    func setupProfileView(){
        profileView.addSubview(backButton)
     
        labelStack = UIStackView(arrangedSubviews: [usernameLabel, detailLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 1
        
        iconView.addSubview(iconImgView)
        
        profileLabelStack = UIStackView(arrangedSubviews: [iconView, labelStack])
        profileLabelStack.axis = .horizontal
        profileLabelStack.spacing = 16
        profileView.addSubview(profileLabelStack)
        
        if(roomStatus == "active"){
            profileView.addSubview(tripleBtn)
        }
    }
    
    func setupProfileLayout(){
        backButton.snp.makeConstraints { make in
            make.height.equalTo(21)
            make.width.equalTo(14)
            make.top.equalToSuperview().offset(83)
            make.left.equalToSuperview().offset(24)
        }
        
        iconView.snp.makeConstraints { make in
            make.height.equalTo(labelStack)
            make.width.equalTo(47)
        }
        
        iconImgView.snp.makeConstraints { make in
            make.height.width.equalTo(46)
            make.centerX.centerY.equalTo(iconView)
        }
        
        profileLabelStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.left.equalTo(backButton).offset(28)
        }
        
        if (roomStatus == "active"){
            tripleBtn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(83)
                make.right.equalToSuperview().offset(26)
                make.height.equalTo(30)
                make.width.equalTo(100)
            }
        }
    }
    
    @objc func backTapped(){
        var vc: UITabBarController = SeekerTabBarVC()
        if (UserProfile.shared.userRole == 1) {
            vc = ListenerTabBarVC()
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @objc func tripleTapped(){
        let tvc = ToEndVC()
        tvc.modalPresentationStyle = .custom
        tvc.modalTransitionStyle = .crossDissolve

        present(tvc, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        messageInputBar.inputTextView.becomeFirstResponder()
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("sending: \(text)")
        let dateString = Self.idDateFormatter.string(from: Date())
        print(dateString)
        
        // insert api post message
        chatViewModel.sendMessage(roomId: currRoomId, message: text)
        
        messages.append(Message(sender: currentUser, messageId: dateString, sentDate: Date(), kind: .text(text)))
        self.messagesCollectionView.reloadDataAndKeepOffset()
        self.messagesCollectionView.scrollToLastItem(animated: false)
        self.messageInputBar.inputTextView.text = nil
    }
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
            let sender = message.sender
        if sender.senderId == "\(UserProfile.shared.userId)" {
                // our message that we've sent
                return .darkPurple
            }
            return .lightPurple
        }
    
    func textColor(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> UIColor {
      isFromCurrentSender(message: message) ? .white : .blackPurple
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) {
        print("configure avatar")
      let avatar = getAvatarFor(sender: message.sender)
      avatarView.set(avatar: avatar)
    }
    
    func getAvatarFor(sender: SenderType) -> Avatar {
      let firstName = sender.displayName.components(separatedBy: " ").first
      let lastName = sender.displayName.components(separatedBy: " ").first
      let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
        
        // nanti avatar diganti sama profile seeker/listener
        if (sender.senderId == "\(UserProfile.shared.userId)"){
            return Avatar(image: selfImage, initials: initials)
        } else {
            return Avatar(image: otherImage, initials: initials)
        }
    }

    func messageBottomLabelAttributedText(for message: MessageType, at _: IndexPath) -> NSAttributedString? {
        let dateMessage = msgDateFormatter.string(from: message.sentDate)
      return NSAttributedString(
        string: dateMessage,
        attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
    func messageBottomLabelHeight(for _: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
      16
    }
    
    

}
