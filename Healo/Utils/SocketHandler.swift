//
//  SocketHandler.swift
//  api
//
//  Created by Vincentius Ian Widi Nugroho on 17/10/22.
//

import Foundation
import SocketIO

class SocketHandler: NSObject {
    static let shared = SocketHandler()
    let socket = SocketManager(socketURL: URL(string: "http://localhost:3001")!, config: [.log(true), .compress])
    var mSocket: SocketIOClient!
    var gotPair: Pair = Pair(id: "", seeker_id: 0, healer_id: 0, status: "", min_age: 0, max_age: 0, prefered_gender: "", seeker_preflection: "")

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
        mSocket.on("got_paired") { [self] ( data, ack) -> Void in
            // apa yang dilakukan kalo dapet data baru
//            let dataReceived = dataArray[0] as! Int
            print("got paired berhasiiil")
            print(data[0])
            let rawData = data[0] as! [String: AnyObject]
            gotPair.id = rawData["id"] as! String
            gotPair.seeker_id = rawData["seeker_id"] as! Int
            gotPair.healer_id = rawData["healer_id"] as! Int
            gotPair.max_age = rawData["max_age"] as! Int
            gotPair.min_age = rawData["min_age"] as! Int
            gotPair.prefered_gender = rawData["prefered_gender"] as! String
            gotPair.seeker_preflection = rawData["preflection"] as! String
            print(rawData["preflection"] ?? "ga nemu")
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
    
    func configurePairing() {
        print(gotPair.status)
        mSocket.emit("confirm_pairing",Pair(id: gotPair.id, seeker_id: gotPair.seeker_id, healer_id: gotPair.healer_id, status: "accept", min_age: gotPair.min_age, max_age: gotPair.max_age, prefered_gender: gotPair.prefered_gender, seeker_preflection: gotPair.seeker_preflection))
    }
    
    func findHealer<T: Decodable>(myStruct: T.Type) {
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
        
        let body = ["min_age": 17,
                    "max_age": 22,
                    "prefered_gender": "F",
                    "preflection": "I feel really uncomfortable today :("
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
                      "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJpYW5nYW50ZW5nIiwidXNlcl9lbWFpbCI6InZpbmNlbnRpYW5udWdyb2hvQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2NjY2NTA1MiwiZXhwIjoxNjY2NzUxNDUyfQ.wmDBK21IdJMvHq8be0tvpJ37pcRL8gDcTD1wzjhFGcw"]
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
            print("data: \(data!)")
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
