//
//  ResendCodeVM.swift
//  Healo
//
//  Created by Hana Salsabila on 15/11/22.
//

import Foundation

class ResendCodeVM {
    static let shared = ResendCodeVM()
    
    func resendCode<T: Decodable>(myStruct: T.Type) {
        guard let url = URL(string: GlobalVariable.url + "/api/auth/resend_validation_code") else {
            print("url error")
            return
        }
        let sem = DispatchSemaphore.init(value: 0)
        print(url)
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard let data = data else {
                print("error creating url session")
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
                print(result)
                guard let user = result.data as? User else {
                    print("not a user")
                    return
                }
                print(user)
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
}
