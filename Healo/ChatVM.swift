//
//  ChatVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 07/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class ChatVM {
    var chatDetail = PublishSubject<ChatDetail>()
    var numOfActiveChat = 0
    
    func fetchChats<T: Decodable>(myStruct: T.Type, roomId: String) {
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: GlobalVariable.url + "/api/chat/" + roomId) else {
            print("url error")
            return
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in defer {sem.signal()}
            
            guard let data = data else {
                print("api request failed")
                return
            }
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                print("chat details:")
                print(result)
                guard let cd = result.data as? ChatDetail else {
                    print("not chat detail")
                    return
                }
                self.chatDetail.on(.next(cd))
            }
            catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
    
    func sendMessage(roomId: String, message: String){
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: GlobalVariable.url + "/api/chat/sent_message") else {
            print("url error")
            return
        }
        print(url)
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json", "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let body = ["room_id": roomId,
                    "message": message,
        ] as [String:Any]

        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            print(error)
        }
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard let data = data else {
                print("error creating url session")
                return
            }
            print(data)
        })
        task.resume()
        sem.wait()
    }
}
