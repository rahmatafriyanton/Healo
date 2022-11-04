//
//  SetUserVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 08/10/22.
//

import Foundation

class SetUserVM {
    static let shared = SetUserVM()
    
    func setUser<T: Decodable>(myStruct: T.Type) {
        let url = URL(string: GlobalVariable.url + "/api/user")
        let sem = DispatchSemaphore.init(value: 0)
        print(url)
        
        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let body = ["user_name": UserProfile.shared.username,
                    "user_email": UserProfile.shared.email,
                    "user_gender": UserProfile.shared.userGender,
                    "user_year_born": UserProfile.shared.userYearBorn,
                    "role_id": UserProfile.shared.userRole,
                    "password": UserProfile.shared.password,
                    "user_is_available": UserProfile.shared.userIsAvailable,
                    "user_goal": UserProfile.shared.userGoal,
                    "user_desc": UserProfile.shared.userDesc,
                    "user_avail_hour": UserProfile.shared.userAvailHour ,
                    "user_profile_pict": UserProfile.shared.userProfilePict,
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
                print("result:")
                print(result)
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
}
