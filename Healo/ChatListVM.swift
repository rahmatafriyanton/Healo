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

//    func fetchUsers() {
//        //MARK: GET DATA OF USER (DUMMY)
//        let user1 = ChatUser(id: 1, profileIcon: "empty-illus", username: "Elvina J.", message: "Hello, apa kabs ?", sentTime: "14.45", numOfMesReceived: 10, chatStatus: "Active", reflectStatus: 0)
//        let user2 = ChatUser(id: 2, profileIcon: "sad-illus", username: "Jacia", message: "Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ?", sentTime: "12.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 0)
//        let user3 = ChatUser(id: 2, profileIcon: "empty-illus", username: "Elvinaa Jc", message: "Halo kamiu ?", sentTime: "11.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 1)
//        
//         let activeSection = SectionModel(model: "Active", items: [user1])
//         let pastSection = SectionModel(model: "Past", items: [user2, user3])
//        
//        self.chatUsers.on(.next([activeSection,pastSection]))
//    }
    
    func fetchChats<T: Decodable>(myStruct: T.Type) {
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: GlobalVariable.url + "/api/chat/") else {
            print("url error")
            return
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [self] data, response, error in defer {sem.signal()}
            
            guard let data = data else {
                print("api request failed")
                return
            }
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                print(result)
                guard let chatlist = result.data as? [ChatList] else {
                    print("not chatlist")
                    return
                }
                print("chatlists:")
                print(chatlist)
                for cl in chatlist {
                    var clAppend = ChatUser(id: cl.roomID, profileIcon: "", username: "", message: cl.lastMessage.message, sentTime: cl.lastMessage.createdAt, numOfMesReceived: cl.numberOfUnread, chatStatus: cl.roomStatus, reflectStatus: 0, roomID: cl.roomID)
                    if (UserProfile.shared.userRole == 1){
                        clAppend.profileIcon = cl.seeker.profilePict
                        clAppend.username = cl.seeker.userName
                    } else if (UserProfile.shared.userRole == 2){
                        clAppend.profileIcon = cl.healer.profilePict
                        clAppend.username = cl.healer.userName
                    }
                    allChats.append(clAppend)
                    print(allChats)
                }
                print("hmhm")
                activeSection.items = allChats.filter { $0.chatStatus.localizedCaseInsensitiveContains("Active")}
                pastSection.items = allChats.filter { $0.chatStatus.localizedCaseInsensitiveContains("Past")}
                
                totalChat = allChats.count
                numOfActiveChat = activeSection.items.count
            }
            catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
    
    func fetchChats(){
        // ntar ini diganti sama urlsession, masukin semua hasil ke allChats
//        let user1 = ChatUser(id: 1, profileIcon: "empty-illus", username: "Elvina J.", message: "Hello, apa kabs ?", sentTime: "14.45", numOfMesReceived: 10, chatStatus: "Active", reflectStatus: 0)
//        let user2 = ChatUser(id: 2, profileIcon: "sad-illus", username: "Jacia", message: "Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ? Hello, baik baik saja anda ?", sentTime: "12.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 0)
//        let user3 = ChatUser(id: 2, profileIcon: "empty-illus", username: "Elvinaa Jc", message: "Halo kamiu ?", sentTime: "11.40", numOfMesReceived: 2, chatStatus: "Past", reflectStatus: 1)
        
//        allChats.append(contentsOf: [user1,user2,user3])
        
        
        
//        activeSection.items = allChats.filter { $0.chatStatus.contains("Active")}
//        pastSection.items = allChats.filter { $0.chatStatus.contains("Past")}
//
//        totalChat = allChats.count
//        numOfActiveChat = activeSection.items.count
    }
    
    func fetchSectionedChats() {
        fetchChats(myStruct: [ChatList].self)
        print("finished fetching chats")
        self.chatUsers.on(.next([activeSection,pastSection]))
    }
    
    func fetchActiveChats() {
        //MARK: GET DATA OF USER (DUMMY)
        fetchChats(myStruct: [ChatList].self)
        self.chatUsers.on(.next([activeSection]))
    }
    
}
