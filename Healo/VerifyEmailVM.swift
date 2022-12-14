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
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = URL(string: GlobalVariable.url + "/api/auth/validate_email") else {
            print("url error")
            return
        }
        print(url)

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json", "x-access-token": UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        print("token yg dipake buat verify email:\(UserProfile.shared.token)")
        
        let body = ["email_validation_key": UserProfile.shared.userEmailValidationKey
        ] as [String:Int]
        print("user key: \(UserProfile.shared.userEmailValidationKey)")
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            print("requestbody: \(requestBody)")
            request.httpBody = requestBody
        } catch {
            print(error)
        }
        
        request.httpMethod = "POST"
        guard let sBody = NSString(data: request.httpBody!, encoding: NSASCIIStringEncoding) else {
            print("sBody error")
            return
        }
        print(sBody)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard let data = data else {
                print("error creating url session")
                return
            }
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                print(result.status)
                print(result.message)
                self.statusVerifyEmail.on(.next(result.status))
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
}

