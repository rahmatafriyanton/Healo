//
//  SocketHandler.swift
//  api
//
//  Created by Vincentius Ian Widi Nugroho on 17/10/22.
//

import Foundation
import SocketIO
import RxSwift
import RxCocoa

class SocketHandler: NSObject {
    static let shared = SocketHandler()
    let socket = SocketManager(socketURL: URL(string: "http://localhost:3001")!, config: [.log(true), .compress])
    var mSocket: SocketIOClient!
    var pairInfo = BehaviorSubject<Pair>(value: Pair(id: "", seeker_id: 0, healer_id: 0, status: "", min_age: 0, max_age: 0, prefered_gender: "", seeker_preflection: ""))

    override init() {
        super.init()
        mSocket = socket.defaultSocket
    }

    func getSocket() -> SocketIOClient {
        return mSocket
    }

    func establishConnection() {
        mSocket.connect()
        print("connected to socket")
    }

    func closeConnection() {
        mSocket.disconnect()
    }
    
    func listenGotPaired() {
        mSocket.on("got_paired") { [] ( data, ack) -> Void in
            // apa yang dilakukan kalo dapet data baru
//            let dataReceived = dataArray[0] as! Int
            print("got paired berhasiiil")
            print(data[0])
            let rawData = data[0] as! [String: AnyObject]
            let gotPair = Pair(
                id : rawData["id"] as! String,
                seeker_id : rawData["seeker_id"] as! Int,
                healer_id : rawData["healer_id"] as! Int,
                status : rawData["status"] as! String,
                min_age : rawData["max_age"] as! Int,
                max_age : rawData["min_age"] as! Int,
                prefered_gender : rawData["prefered_gender"] as! String,
                seeker_preflection : rawData["preflection"] as! String)
            self.pairInfo.on(.next(gotPair))
        }
    }
    
    func listenChatSession() {
        mSocket.on("chat_session_created") { ( data, ack) -> Void in
            // navigate ke chat list
            print("chat session terbuaat")
            print(data)
        }
    }
    
    func createConnection(id: Int) {
        print("connectinging")
        mSocket.emit("create_connection",id)
    }
    
    func acceptPairing() {
//        print(gotPair.status)
//        mSocket.emit("confirm_pairing",Pair(id: gotPair.id, seeker_id: gotPair.seeker_id, healer_id: gotPair.healer_id, status: "accept", min_age: gotPair.min_age, max_age: gotPair.max_age, prefered_gender: gotPair.prefered_gender, seeker_preflection: gotPair.seeker_preflection))
    }
    
    func findHealer<T: Decodable>(myStruct: T.Type, minAge: Int, maxAge: Int, preferGender: String, preflek: String) {
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: GlobalVariable.url + "/api/chat/find_healer")
        print(url)
        
        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token": UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let body = ["min_age": minAge,
                    "max_age": maxAge,
                    "prefered_gender": preferGender,
                    "preflection": preflek
        ] as [String:Any]

        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            print(error)
        }
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard data != nil && error == nil else {
                print("error creating url session")
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                print(result.status)
                print("berhasil find healer")
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
    
    func addHealerToQueue(isAvailable: Int) {
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: GlobalVariable.url + "/api/chat/healer/queue")
        print(url)
        
        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJpYW5nYW50ZW5nIiwidXNlcl9lbWFpbCI6InZpbmNlbnRpYW5udWdyb2hvQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2Njc3MjY2OCwiZXhwIjoxNjY2ODU5MDY4fQ.nDpmVpWcbfuAjJDpsSdwmnZ_XeC0M0OdICaFqFJ6yaw"]
        request.allHTTPHeaderFields = header
        
        let body = ["is_available": isAvailable
        ] as [String:Any]

        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            print(error)
        }
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard data != nil && error == nil else {
                print("error creating url session")
                return
            }
            print("added listener to queue")
//            do {
//                print("decoding")
//                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
//                print(result.status)
//            } catch {
//                print(error)
//            }
        })
        task.resume()
        sem.wait()
    }
}
