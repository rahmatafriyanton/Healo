//
//  User.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 25/10/22.
//

import Foundation

struct User: Decodable {
    let userID, roleID: Int
    let userName, userEmail: String
    let userIsAvailable: Bool
    let userGender: String
    let userYearBorn: Int
    let userGoal, userAvailHour, userDesc: String
    let userProfilePict: String
    let isEmailValidated: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case roleID = "role_id"
        case userName = "user_name"
        case userEmail = "user_email"
        case userIsAvailable = "user_is_available"
        case userGender = "user_gender"
        case userYearBorn = "user_year_born"
        case userGoal = "user_goal"
        case userAvailHour = "user_avail_hour"
        case userDesc = "user_desc"
        case userProfilePict = "user_profile_pict"
        case isEmailValidated = "is_email_validated"
    }
}
