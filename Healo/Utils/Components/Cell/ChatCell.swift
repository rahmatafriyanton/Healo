//
//  ChatCell.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit

class ChatCell: UITableViewCell {

    let profileIconDim : CGFloat = 55
    
    lazy var chatView : UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconView : UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 28
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.frame.size.width = 60
        icon.frame.size.height = 60
        return icon
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsMedium(size: 16)
        label.textColor = .blackPurple
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 14)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.textColor = .lightGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 12)
        label.textColor = .white
        label.backgroundColor = .redNotif
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorLine: UIView = {
        let separator = UIView()
        separator.contentMode = .scaleAspectFit
        separator.backgroundColor = .lightGray
        separator.clipsToBounds = true
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configureUI(){
        setupView()
        setupLayout()
    }
    
    func setupView(){
        addSubview(chatView)
        chatView.addSubview(iconView)
        iconView.addSubview(profileIcon)
        chatView.addSubview(usernameLabel)
        chatView.addSubview(messageLabel)
        chatView.addSubview(timeLabel)
        chatView.addSubview(badgeLabel)
        chatView.addSubview(separatorLine)
    }
    
    func setupLayout(){
        setChatViewLayout()
        setIconViewLayout()
        setProfileIconLayout()
        setUsernameLayout()
        setMessageLayout()
        setTimeLayout()
        setBadgeLayout()
        setSeparatorLayout()
    }
    
    func setChatViewLayout(){
        chatView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        chatView.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0).isActive = true
        chatView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chatView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        chatView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        chatView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func setIconViewLayout(){
        iconView.centerYAnchor.constraint(equalTo: chatView.centerYAnchor, constant: 0).isActive = true
        iconView.leftAnchor.constraint(equalTo: chatView.leftAnchor, constant: 20).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: profileIconDim).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: profileIconDim).isActive = true
    }
    
    func setProfileIconLayout(){
        profileIcon.centerYAnchor.constraint(equalTo: iconView.centerYAnchor, constant: 0).isActive = true
        profileIcon.centerXAnchor.constraint(equalTo: iconView.centerXAnchor,constant: 0).isActive = true
    }
    
    func setUsernameLayout(){
        usernameLabel.topAnchor.constraint(equalTo: chatView.topAnchor, constant: 10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 20).isActive = true
    }
    
    func setMessageLayout(){
        messageLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: chatView.rightAnchor, constant: -50).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 25).isActive = true
        messageLabel.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 100, height: 50))

    }
    
    func setTimeLayout(){
        timeLabel.topAnchor.constraint(equalTo: chatView.topAnchor, constant: 10).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func setBadgeLayout(){
        badgeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15).isActive = true
        badgeLabel.bottomAnchor.constraint(equalTo: chatView.bottomAnchor, constant: -20).isActive = true
        badgeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func setSeparatorLayout(){
        separatorLine.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: chatView.widthAnchor, constant: -105).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: chatView.leftAnchor, constant: 95).isActive = true
    }
    
}

