//
//  UserProfile.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 05/10/22.
//

import Foundation
class UserProfile {
    
    private var _username: String
    private var _email: String
    private var _password: String
    private var _isAcceptAgreement: Int
    private var _agreementTime: String
    private var _userRole: Int
    
    private var _userGender: String
    private var _userYearBorn: Int
    private var _userProfilePict: String
    
    private var _token: String
    
    static let shared = UserProfile()
    
    private init() {
        self._username = UserDefaults.standard.string(forKey: "username") ?? "no username"
        self._email = UserDefaults.standard.string(forKey: "email") ?? "no email"
        self._password = UserDefaults.standard.string(forKey: "password") ?? "no password"
        self._isAcceptAgreement = UserDefaults.standard.integer(forKey: "isAcceptAgreement")
        self._agreementTime = UserDefaults.standard.string(forKey: "agreementTime") ?? "no time"
        self._userRole = UserDefaults.standard.integer(forKey: "userRole")
        
        self._userGender = UserDefaults.standard.string(forKey: "userGender") ?? "no gender"
        self._userYearBorn = UserDefaults.standard.integer(forKey: "userYearBorn")
        self._userProfilePict = UserDefaults.standard.string(forKey: "userProfilePict") ?? "no profile pict"
        
        self._token = UserDefaults.standard.string(forKey: "token") ?? "no token"
    }
    
    var username: String {
        get {
            return self._username
        }
        set(newValue) {
            self._username = newValue
            UserDefaults.standard.set(newValue, forKey: "username")
        }
    }
    
    var email: String {
        get {
            return self._email
        }
        set(newValue) {
            self._email = newValue
            UserDefaults.standard.set(newValue, forKey: "email")
        }
    }
    
    var password: String {
        get {
            return self._password
        }
        set(newValue) {
            self._password = newValue
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
    
    var isAcceptAgreement: Int {
        get {
            return self._isAcceptAgreement
        }
        set(newValue) {
            self._isAcceptAgreement = newValue
            UserDefaults.standard.set(newValue, forKey: "isAcceptAgreement")
        }
    }
    
    var agreementTime: String {
        get {
            return self._agreementTime
        }
        set(newValue) {
            self._agreementTime = newValue
            UserDefaults.standard.set(newValue, forKey: "agreementTime")
        }
    }
    
    var userRole: Int {
        get {
            return self._userRole
        }
        set(newValue) {
            self._userRole = newValue
            UserDefaults.standard.set(newValue, forKey: "userRole")
        }
    }
    
    var userGender: String {
        get {
            return self._userGender
        }
        set(newValue) {
            self._userGender = newValue
            UserDefaults.standard.set(newValue, forKey: "userGender")
        }
    }
    
    var userYearBorn: Int {
        get {
            return self._userYearBorn
        }
        set(newValue) {
            self._userYearBorn = newValue
            UserDefaults.standard.set(newValue, forKey: "userYearBorn")
        }
    }
    
    var userProfilePict: String {
        get {
            return self._userProfilePict
        }
        set(newValue) {
            self._userProfilePict = newValue
            UserDefaults.standard.set(newValue, forKey: "userProfilePict")
        }
    }
    
    var token: String {
        get {
            return self._token
        }
        set(newValue) {
            self._token = newValue
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
}
