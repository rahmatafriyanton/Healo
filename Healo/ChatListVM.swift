//
//  ChatListVM.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ChatListVM {
    var chatUsers = BehaviorSubject(value: [SectionModel(model: "", items: [ChatUser]())])
    var totalChat = 1 //ini tar hrs calculate total semua chat (active & past)
    var numOfActiveChat = 0
    var allChats: [ChatUser] = []
    var activeSection = SectionModel(model: "Active", items: [ChatUser]())
    var pastSection = SectionModel(model: "Past", items: [ChatUser]())

    func fetchUsers() {
        //MARK: GET DATA OF USER (DUMMY)
        let user1 = ChatUser(id: 1, profileIcon: "empty-illus", username: "Elvina J.", message: "Hello, apa kabs ?", sentTime: "14.45", numOfMesReceived: 10, chatStatus: "Active", reflectStatus: 0)
        let user2 = ChatUser(id: 2, profileIcon: "sad-illus", username: "Jacia", message: "Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ?", sentTime: "12.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 0)
        let user3 = ChatUser(id: 2, profileIcon: "empty-illus", username: "Elvinaa Jc", message: "Halo kamiu ?", sentTime: "11.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 1)
        
         let activeSection = SectionModel(model: "Active", items: [user1])
         let pastSection = SectionModel(model: "Past", items: [user2, user3])
        
        self.chatUsers.on(.next([activeSection,pastSection]))
    }
    
    func fetchChats(){
        // ntar ini diganti sama urlsession, masukin semua hasil ke allChats
        let user1 = ChatUser(id: 1, profileIcon: "empty-illus", username: "Elvina J.", message: "Hello, apa kabs ?", sentTime: "14.45", numOfMesReceived: 10, chatStatus: "Active", reflectStatus: 0)
        let user2 = ChatUser(id: 2, profileIcon: "sad-illus", username: "Jacia", message: "Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ?", sentTime: "12.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 0)
        let user3 = ChatUser(id: 2, profileIcon: "empty-illus", username: "Elvinaa Jc", message: "Halo kamiu ?", sentTime: "11.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 1)
        
        allChats.append(contentsOf: [user1,user2,user3])
        
        activeSection.items = allChats.filter { $0.chatStatus.contains("Active")}
        pastSection.items = allChats.filter { $0.chatStatus.contains("Past")}
        
        totalChat = allChats.count
        numOfActiveChat = activeSection.items.count
    }
    
    func fetchSectionedChats() {
        fetchChats()
        self.chatUsers.on(.next([activeSection,pastSection]))
    }
    
    func fetchActiveChats() {
        //MARK: GET DATA OF USER (DUMMY)
        fetchChats()
        self.chatUsers.on(.next([activeSection]))
    }
    
}
