//
//  RegisterViewModel.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 05/10/22.
//

import Foundation

class RegisterViewModel {
    static let shared = RegisterViewModel()
    
    func register() {
        let url = URL(string: "http://localhost:3000/api/auth/signup")
        
        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json"]
        request.allHTTPHeaderFields = header
        
        let body = ["username": UserProfile.shared.username,
                    "email": UserProfile.shared.email,
                    "password": UserProfile.shared.password,
                    "is_accept_agreement": UserProfile.shared.isAcceptAgreement,
                    "agreement_time": UserProfile.shared.agreementTime,
                    "user_role": UserProfile.shared.userRole,
                    "user_gender": UserProfile.shared.userGender,
                    "user_year_born": UserProfile.shared.userYearBorn,
                    "user_profile_pict": UserProfile.shared.userProfilePict,
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
                let result = try JSONDecoder().decode(Response.self, from: data!)
                UserProfile.shared.token = result.data.token
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}
