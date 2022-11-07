//
//  EditIconVM.swift
//  Healo
//
//  Created by Hana Salsabila on 26/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class EditIconVM {
    static let shared = EditIconVM()
    var icons = BehaviorSubject(value: [Icon]())
    
    func getIcons<T: Decodable>(myStruct: T.Type) {
        guard let url = URL(string: GlobalVariable.url + "/api/user/profile_images") else {
            print("url error")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let data = data else {
                print("api request failed")
                return
            }
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data)
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
