//
//  EndChatVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 08/11/22.
//

import Foundation

class EndChatVM {
    static let shared = EndChatVM()
    
    func endChat(reason: String) {
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: GlobalVariable.url + "/api/chat/end_chat") else {
            print("url error")
            return
        }
        print(url)
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token": UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let body = ["room_id": UserProfile.shared.currentRoomId,
                    "room_closed_reason": reason,
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
