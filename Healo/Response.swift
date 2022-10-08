//
//  Response.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 05/10/22.
//

import Foundation

struct Response<T: Decodable> : Decodable {
    let status: String
    let message: String
    let data: T
}

