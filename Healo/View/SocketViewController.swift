//
//  SocketViewController.swift
//  api
//
//  Created by Vincentius Ian Widi Nugroho on 17/10/22.
//

import UIKit

class SocketViewController: UIViewController {
    
    var mSocket = SocketHandler.shared.getSocket()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureUI()
        print("loaded")
        // untuk establish connection
        SocketHandler.shared.establishConnection()
        // untuk nerima data
        SocketHandler.shared.listenGotPaired()
        SocketHandler.shared.listenChatSession()
//        self.timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { [self] _ in
//            SocketHandler.shared.addHealerToQueue(isAvailable: 1)
//        })
//        mSocket.on("got_paired") { ( data, ack) -> Void in
//            // apa yang dilakukan kalo dapet data baru
////            let dataReceived = dataArray[0] as! Int
//            print(data)
//        }
        
//        mSocket.on("chat_session_created") { ( data, ack) -> Void in
//            // apa yang dilakukan kalo dapet data baru
//            let dataReceived = dataArray[0] as! Int
//            print(dataReceived)
//        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "I'm a test label"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var btnKonek1: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.text = "listener konek"
        btn.setTitle("listener konek", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.addTarget(self, action: #selector(createConnectionlistener1), for: .touchUpInside)
        // hrs ada ini dulu baru muncul
        return btn
    }()
    
    private lazy var btnKonek2: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.text = "seeker konek"
        btn.setTitle("seekr konek", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.addTarget(self, action: #selector(createConnectionlistener2), for: .touchUpInside)
        // hrs ada ini dulu baru muncul
        return btn
    }()
    
    private lazy var btnAddQueue: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.text = "add healer to queue"
        btn.setTitle("add healer to q", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.addTarget(self, action: #selector(addToQueue), for: .touchUpInside)
        // hrs ada ini dulu baru muncul
        return btn
    }()
    
    private lazy var btnFindHealer: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.text = "find healer"
        btn.setTitle("find healer", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.addTarget(self, action: #selector(findHealer), for: .touchUpInside)
        // hrs ada ini dulu baru muncul
        return btn
    }()
    
    private lazy var btnAccPair: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.text = "find healer"
        btn.setTitle("acc pairing", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.addTarget(self, action: #selector(configurePairing), for: .touchUpInside)
        // hrs ada ini dulu baru muncul
        return btn
    }()
    
    @objc func createConnectionlistener1(){
        // untuk emmit data ke server, ganti key dan value sesuai yg diinginkan
//        mSocket.emit("counter")
        // klo mau ada valuenya:
//        mSocket.emit("counter", variable)
        
//        mSocket.emit("create_connection",1)
        SocketHandler.shared.createConnection(id: 1)
    }
    
    @objc func createConnectionlistener2(){
        // untuk emmit data ke server, ganti key dan value sesuai yg diinginkan
//        mSocket.emit("counter")
        // klo mau ada valuenya:
//        mSocket.emit("counter", variable)
        
//        mSocket.emit("create_connection",2)
        SocketHandler.shared.createConnection(id: 2)
    }
    
    @objc func configurePairing(){
        SocketHandler.shared.configurePairing()
    }
    
    @objc func addToQueue(){
        SocketHandler.shared.addHealerToQueue(isAvailable: 1)
    }
    
    @objc func findHealer(){
        SocketHandler.shared.findHealer(myStruct: [String].self)
    }
    
    func configureUI(){
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.top.equalToSuperview().offset(80)
        }
        
        view.addSubview(btnKonek1)
        btnKonek1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.height.equalTo(52)
        }
        
        view.addSubview(btnKonek2)
        btnKonek2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.top.equalTo(btnKonek1.snp.bottom).offset(20)
            make.height.equalTo(52)
        }
        
        view.addSubview(btnAddQueue)
        btnAddQueue.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.top.equalTo(btnKonek2.snp.bottom).offset(20)
            make.height.equalTo(52)
        }
        
        view.addSubview(btnFindHealer)
        btnFindHealer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.top.equalTo(btnAddQueue.snp.bottom).offset(20)
            make.height.equalTo(52)
        }
        
        view.addSubview(btnAccPair)
        btnAccPair.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.top.equalTo(btnFindHealer.snp.bottom).offset(20)
            make.height.equalTo(52)
        }

    }

}
