//
//  GetUserVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 25/10/22.
//

import Foundation

class GetUserVM {
    static let shared = GetUserVM()
    
    func getUser<T: Decodable>(myStruct: T.Type) {
        let url = URL(string: GlobalVariable.url + "/api/user")
        let sem = DispatchSemaphore.init(value: 0)
        print(url)
        
//        guard url != nil else{
//            print("url error")
//            return
//        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in defer { sem.signal() }
            guard data != nil && error == nil else {
                print("error creating url session")
                return
            }
            do {
                print("decoding")
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                print(result)
                guard let user = result.data as? User else {
                    print("not a user")
                    return
                }
                UserProfile.shared.userId = user.userID
                UserProfile.shared.userRole = user.roleID
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
}
