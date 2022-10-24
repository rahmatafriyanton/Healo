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

class ChatVC: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate  {

    // ntar ganti jadi let currentUser = Sender, pass data dari chat list
    var currentUser = Sender(senderId: "self", displayName: "seeker")
    var otherUser = Sender(senderId: "other", displayName: "listener")
    
    var messages = [MessageType]()
    
    var selfImage: UIImage? = nil
    var otherImage: UIImage? = nil
    
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
    
    // insert func socket async, isinya append si chat terakhir

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureUI()
        self.messagesCollectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        messageInputBar.inputTextView.becomeFirstResponder()
        print("loaded")
        
        currentUser = Sender(senderId: "self", displayName: UserProfile.shared.username)
        otherUser = Sender(senderId: "other", displayName: UserProfile.shared.username)
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("halooo")))
        
        // simpen image sendiri
        let urlSelfImage = URL(string: "\(GlobalVariable.url)\(UserProfile.shared.userProfilePict)")!

        let dataTaskSelfImage = URLSession.shared.dataTask(with: urlSelfImage) { [weak self] (data, _, _) in
            if let data = data {
                // Create Image and Update Image View
                print("get image")
                self?.selfImage = UIImage(data: data)
            }
        }
        dataTaskSelfImage.resume()
        
        // simpen image lawan bicara
        let urlOtherImage = URL(string: "\(GlobalVariable.url)\("imej.jpg")")!

        let dataTaskOtherImage = URLSession.shared.dataTask(with: urlOtherImage) { [weak self] (data, _, _) in
            if let data = data {
                // Create Image and Update Image View
                print("get image")
                self?.otherImage = UIImage(data: data)
            }
        }
        dataTaskOtherImage.resume()
    }
    
    func configureUI(){
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(162)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalTo(profileView.snp.bottom)
            make.height.equalTo(58)
        }
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
            if sender.senderId == "self" {
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
        if (sender.senderId == "self"){
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
