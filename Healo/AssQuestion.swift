//
//  AssQuestion.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 15/10/22.
//

import Foundation

struct AssQuestion: Decodable {
    let question_id: Int
    let question_number: Int
    let title: String
    let description: String
    let question: String
    let answers: [AssAnswer]
}

struct AssAnswer: Decodable {
    let answer_id: Int
    let answer: String
}
