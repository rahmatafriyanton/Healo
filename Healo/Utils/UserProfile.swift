//
//  UserProfile.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 05/10/22.
//

import Foundation
class UserProfile {
    
    private var _userId: Int
    private var _username: String
    private var _email: String
    private var _password: String
    private var _isAcceptAgreement: Int
    private var _agreementTime: String
    private var _userRole: Int
    
    private var _userGender: String
    private var _userYearBorn: Int
    private var _userProfilePict: String
    
    private var _userIsAvailable: Int
    private var _userGoal: String
    private var _userDesc: String
    private var _userAvailHour: String
    
    private var _token: String
    
    private var _userEmailValidationKey: Int
    
    static let shared = UserProfile()
    
    private init() {
        self._userId = UserDefaults.standard.integer(forKey: "userId")
        self._username = UserDefaults.standard.string(forKey: "username") ?? "ian_healo"
        self._email = UserDefaults.standard.string(forKey: "email") ?? "vincentiannugroho@gmail.com"
        self._password = UserDefaults.standard.string(forKey: "password") ?? "Password"
        self._isAcceptAgreement = UserDefaults.standard.integer(forKey: "isAcceptAgreement")
        self._agreementTime = UserDefaults.standard.string(forKey: "agreementTime") ?? "no time"
        self._userRole = UserDefaults.standard.integer(forKey: "userRole")
        
        self._userGender = UserDefaults.standard.string(forKey: "userGender") ?? "M"
        self._userYearBorn = UserDefaults.standard.integer(forKey: "userYearBorn")
        self._userProfilePict = UserDefaults.standard.string(forKey: "userProfilePict") ?? "http://fhdjdfd.com/img"
        
        self._token = UserDefaults.standard.string(forKey: "token") ?? "no token"
        
        self._userIsAvailable = UserDefaults.standard.integer(forKey: "userIsAvailable")
        self._userGoal = UserDefaults.standard.string(forKey: "userGoal") ?? "no goal"
        self._userDesc = UserDefaults.standard.string(forKey: "userDesc") ?? "no desc"
        self._userAvailHour = UserDefaults.standard.string(forKey: "userAvailHour") ?? "no avail"
        
        self._userEmailValidationKey = UserDefaults.standard.integer(forKey: "userEmailValidationKey")
    }
    
    var userId: Int {
        get {
            return self._userId
        }
        set(newValue) {
            self._userId = newValue
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
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
    
    var userIsAvailable: Int {
        get {
            return self._userIsAvailable
        }
        set(newValue) {
            self._userIsAvailable = newValue
            UserDefaults.standard.set(newValue, forKey: "userIsAvailable")
        }
    }
    
    var userGoal: String {
        get {
            return self._userGoal
        }
        set(newValue) {
            self._userGoal = newValue
            UserDefaults.standard.set(newValue, forKey: "userGoal")
        }
    }
    
    var userDesc: String {
        get {
            return self._userDesc
        }
        set(newValue) {
            self._userDesc = newValue
            UserDefaults.standard.set(newValue, forKey: "userDesc")
        }
    }
    
    var userAvailHour: String {
        get {
            return self._userAvailHour
        }
        set(newValue) {
            self._userAvailHour = newValue
            UserDefaults.standard.set(newValue, forKey: "userAvailHour")
        }
    }
    
    var userEmailValidationKey: Int {
        get {
            return self._userEmailValidationKey
        }
        set(newValue) {
            self._userEmailValidationKey = newValue
            UserDefaults.standard.set(newValue, forKey: "userEmailValidationKey")
        }
    }
}
