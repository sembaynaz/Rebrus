//
//  Configurations.swift
//  Rebrus
//
//

import Foundation
struct Configuration {
    static let BASE_URL = "http://18.153.73.242/"
    
    static let SIGN_IN_URL = BASE_URL + "auth/login"
    static let SIGN_UP_URL = BASE_URL + "auth/register"
    static let DELETE_ACCOUNT = BASE_URL + "auth/delete-account"
    static let CHECK_CODE = BASE_URL + "auth/check-verification-code"
    static let RESEND_CODE = BASE_URL + "auth/resend-verification-code"
}

class Storage {
    public var accessToken: String = ""
    
    static let sharedInstance = Storage()
}
