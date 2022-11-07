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
        guard let url = URL(string: GlobalVariable.url + "/api/auth/verify_token") else {
            print("url error")
            return ""
        }
        print(url as Any)
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard let data = data else {
                print("error creating url session")
                print(error as Any)
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                print(result.status)
                print(result.data)
                self.status = result.status
                
                // harusnya ga perlu
                guard let token = result.data as? Token else {
                    print("not a token")
                    return
                }
                print(token.token)
                UserProfile.shared.token = token.token
                // harusnya ga perlu
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
