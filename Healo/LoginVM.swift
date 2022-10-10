//
//  LoginVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 08/10/22.
//

import Foundation

class LoginVM {
    static let shared = LoginVM()
    
    func login<T: Decodable>(myStruct: T.Type) {
        let url = URL(string: GlobalVariable.url + "api/auth/login")
        print(url)
        
        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json"]
        request.allHTTPHeaderFields = header
        
        let body = ["user_email": UserProfile.shared.email,
                    "password": UserProfile.shared.password,
        ] as [String:Any]

        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            print(error)
        }
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in
            guard data != nil && error == nil else {
                print("error creating url session")
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
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
    }
}
