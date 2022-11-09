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
        guard let url = URL(string: GlobalVariable.url + "/api/user") else {
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
                UserProfile.shared.userId = user.userID
                UserProfile.shared.userRole = user.roleID
                UserProfile.shared.username = user.userName
                UserProfile.shared.email = user.userEmail
                UserProfile.shared.userGender = user.userGender ?? ""
                UserProfile.shared.userYearBorn = user.userYearBorn ?? 0
                UserProfile.shared.userProfilePict = user.userProfilePict ?? ""
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
}
