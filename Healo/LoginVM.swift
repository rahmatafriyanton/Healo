//
//  LoginVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 08/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class LoginVM {
    static let shared = LoginVM()
    var statusLogin = BehaviorSubject<String>(value: "initial value")
    
    func login<T: Decodable>(myStruct: T.Type) {
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: GlobalVariable.url + "/api/auth/login")
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
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard data != nil && error == nil else {
                print("error creating url session")
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                print(result.status)
                self.statusLogin.on(.next(result.status))
                
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
    }
}
