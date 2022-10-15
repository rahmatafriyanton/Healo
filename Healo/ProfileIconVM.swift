//
//  ProfileIconVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 11/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileIconVM {
    static let shared = ProfileIconVM()
    var icons = BehaviorSubject(value: [Icon]())
    
    func getIcons<T: Decodable>(myStruct: T.Type) {
        let url = URL(string: GlobalVariable.url + "/api/user/profile_images")

        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozLCJ1c2VyX25hbWUiOiJpYW5nYW50ZW5nIiwidXNlcl9lbWFpbCI6InZpbmNlbnRpYW5udWdyb2hvQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2NTY1OTEwNSwiZXhwIjoxNjY1NzQ1NTA1fQ.EBsAGusP-ReO62g9278nzarpYsKdtCYYW6-iA2KLOpc"]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard data != nil, error == nil else {
                print("api request failed")
                return
            }
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                guard let ikons = result.data as? [Icon] else {
                    print("not icons")
                    return
                }
                self.icons.on(.next(ikons))
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
}
