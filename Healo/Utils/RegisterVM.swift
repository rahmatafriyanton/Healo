//
//  RegisterViewModel.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 05/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterVM {
    static let shared = RegisterVM()
    var statusRegister = BehaviorSubject<String>(value: "initial value")
    
    func register<T: Decodable>(myStruct: T.Type) {
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: GlobalVariable.url + "/api/auth/register") else {
            print("url error")
            return
        }
        print(url)
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json"]
        request.allHTTPHeaderFields = header
        
        let body = ["user_name": UserProfile.shared.username,
                    "user_email": UserProfile.shared.email,
                    "password": UserProfile.shared.password,
                    "is_accept_agreement": UserProfile.shared.isAcceptAgreement,
                    "agreement_time": UserProfile.shared.agreementTime,
                    "role_id": UserProfile.shared.userRole,
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
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                print(result)
                self.statusRegister.on(.next(result.status))
                
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
