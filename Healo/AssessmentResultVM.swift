//
//  AssessmentResultVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 12/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class AssessmentResultVM {
    static let shared = AssessmentResultVM()
    var assResult = BehaviorSubject<AssResult>(value: AssResult(status: "", score: 0, total_score: 0))
    
    var result = AssResult(status: "", score: 0, total_score: 0)
    var fetchStatus = false
    
    func makeAssessment<T: Decodable>(myStruct: T.Type, answers: [QuestionAnswer]) {
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: GlobalVariable.url + "/api/assessment/")
        
        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json","x-access-token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozLCJ1c2VyX25hbWUiOiJpYW5nYW50ZW5nIiwidXNlcl9lbWFpbCI6InZpbmNlbnRpYW5udWdyb2hvQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY2NTgyNzk3MywiZXhwIjoxNjY1OTE0MzczfQ.NuSCgHkdq-fASeOV0f4vbnVa3VGVPFQkP0-K4uiqits"]
        request.allHTTPHeaderFields = header
        
        let body = answers
        
        do {
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(body)
            request.httpBody = requestBody
        } catch {
            print("error encoding body")
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
                print(result)
                guard let resultData = result.data as? AssResult else {
                    print("not assessment results")
                    return
                }
                self.result = resultData
                self.fetchStatus = true
                self.assResult.on(.next(resultData))
            } catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
    
    public func getAssResult() {
//        let result = 
        return
    }
}
