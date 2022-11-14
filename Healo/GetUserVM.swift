//
//  GetUserVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 25/10/22.
//

import Foundation

enum ProfileError : Error {
    case userIDEmpty, roleIDEmpty, userNameEmpty, userEmailEmpty, userGenderEmpty, userYearBornEmpty, profilePictEmpty
}

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
//                UserProfile.shared.userId = user.userID
//                UserProfile.shared.userRole = user.roleID
//                UserProfile.shared.username = user.userName
//                UserProfile.shared.email = user.userEmail
//                UserProfile.shared.userGender = user.userGender ?? ""
//                UserProfile.shared.userYearBorn = user.userYearBorn ?? 0
//                UserProfile.shared.userProfilePict = user.userProfilePict ?? ""
                try self.checkProfile(userId: user.userID, roleID: user.roleID, userName: user.userName, userEmail: user.userEmail, userGender: user.userGender ?? "", userYearBorn: user.userYearBorn ?? 0, profilePict: user.userProfilePict ?? "")
                  print("Valid Division")
            } catch ProfileError.userIDEmpty {
                print("Error: user ID cannot be Empty")
            } catch ProfileError.roleIDEmpty {
                print("Error: role ID cannot be Empty")
            } catch ProfileError.userNameEmpty {
                print("Error: username cannot be Empty")
            } catch ProfileError.userEmailEmpty {
                print("Error: email cannot be Empty")
            } catch ProfileError.userGenderEmpty {
                print("Error: gender cannot be Empty")
            } catch ProfileError.userYearBornEmpty {
                print("Error: Year Born cannot be Empty")
            } catch ProfileError.profilePictEmpty {
                print("Error: Profile Pict cannot be Empty")
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
    
    func checkProfile(userId: Int, roleID: Int, userName: String, userEmail: String, userGender: String, userYearBorn: Int, profilePict: String) throws {
        if userId == 0 {
          throw ProfileError.userIDEmpty
        } else {
          UserProfile.shared.userId = userId
          print(userId)
        }
        
        if roleID == 0 {
          throw ProfileError.roleIDEmpty
        } else {
          UserProfile.shared.userRole = roleID
          print(roleID)
        }
        
        if userName.isEmpty == true {
          throw ProfileError.userNameEmpty
        } else {
          UserProfile.shared.username = userName
          print(userName)
        }
        
        if userEmail.isEmpty == true {
          throw ProfileError.userEmailEmpty
        } else {
          UserProfile.shared.email = userEmail
          print(userEmail)
        }
        
        if userGender.isEmpty == true {
          throw ProfileError.userGenderEmpty
        } else {
          UserProfile.shared.userGender = userGender
          print(userGender)
        }
        
        if userYearBorn == 0 {
          throw ProfileError.userYearBornEmpty
        } else {
          UserProfile.shared.userYearBorn = userYearBorn
          print(userYearBorn)
        }

        if profilePict.isEmpty == true {
          throw ProfileError.profilePictEmpty
        } else {
          UserProfile.shared.userProfilePict = profilePict
          print(profilePict)
        }
    }
}
