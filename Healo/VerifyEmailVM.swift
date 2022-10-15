//
//  VerifyEmailVM.swift
//  Healo
//
//  Created by Hana Salsabila on 11/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class VerifyEmailVM {
    static let shared = VerifyEmailVM()
    var statusVerifyEmail = BehaviorSubject<String>(value: "initial value")
    
    func verifyEmail<T: Decodable>(myStruct: T.Type) {
        let url = URL(string: GlobalVariable.url + "api/auth/validate_email")
        print(url)
        
        guard url != nil else {
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json", "x-access-token": UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let body = ["email_validation_key": UserProfile.shared.userEmailValidationKey
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
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                print(result.status)
                self.statusVerifyEmail.on(.next(result.status))
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}

