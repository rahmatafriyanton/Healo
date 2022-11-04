//
//  VerifyToken.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 02/11/22.
//

import Foundation

class VerifyToken {
    static let shared = VerifyToken()
    var status: String = ""
    
    func verify<T: Decodable>(myStruct: T.Type) -> String {
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: GlobalVariable.url + "/api/auth/verify_token")
        print(url as Any)
        
        guard url != nil else{
            print("url error")
            return ""
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard data != nil && error == nil else {
                print("error creating url session")
                print(error as Any)
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                print(result.status)
                self.status = result.status
                
                guard let token = result.data as? Token else {
                    print("not a token")
                    return
                }
                print(token.token)
                UserProfile.shared.token = token.token
            } catch {
                print(error)
            }
            
        })
        task.resume()
        sem.wait()
        print("status token:" + status)
        return status
    }
}
