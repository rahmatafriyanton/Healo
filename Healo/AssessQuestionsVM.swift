//
//  AssessQuestionsVM.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 15/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class AssessQuestionsVM {
    static let shared = AssessQuestionsVM()
    var assQuestions = BehaviorSubject(value: [AssQuestion]())
    var currassQuestions = ReplaySubject<AssQuestion>.create(bufferSize: 1)
//    var currassQuestions = PublishSubject<AssQuestion>()
    
    func getQuestions<T: Decodable>(myStruct: T.Type) {
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: GlobalVariable.url + "/api/assessment/question")

        guard url != nil else{
            print("url error")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let header = ["Content-Type":"application/json",
                      "x-access-token":UserProfile.shared.token]
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in defer {sem.signal()}
            
            guard data != nil, error == nil else {
                print("api request failed")
                return
            }
            do {
                let result = try JSONDecoder().decode(Response<T>.self, from: data!)
                print(result)
                guard let questions = result.data as? [AssQuestion] else {
                    print("not questions")
                    return
                }
                self.assQuestions.on(.next(questions))
                print(questions)
//                self.currassQuestions.on(.next(questions[0]))
            }
            catch {
                print(error)
            }
        })
        task.resume()
        sem.wait()
    }
}
