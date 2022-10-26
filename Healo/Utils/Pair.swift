//
//  Pair.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 25/10/22.
//

import Foundation
import SocketIO

struct Pair : SocketData {
    var id: String
    var seeker_id: Int
    var healer_id: Int
    var status: String
    var min_age: Int
    var max_age: Int
    var prefered_gender: String
    var seeker_preflection: String
    
    func socketRepresentation() throws -> SocketData {
        return ["id": id,"seeker_id":seeker_id,"healer_id":healer_id,"status":status,"min_age":min_age,"max_age":max_age,"prefered_gender":prefered_gender,"seeker_preflection":seeker_preflection]
    }
}
