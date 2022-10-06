//
//  Response.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 05/10/22.
//

import Foundation

struct Response: Codable {
    let status: String
    let message: String
    let data: Token
}

struct Token: Codable {
    let token: String
}
