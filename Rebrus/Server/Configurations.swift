//
//  Configurations.swift
//  Rebrus
//
//

import Foundation
struct Configuration {
    static let BASE_URL = "http://167.71.48.186:8080/"
    
    static let SIGN_IN_URL = BASE_URL + "auth/login"
    static let SIGN_UP_URL = BASE_URL + "auth/register"
    static let DELETE_ACCOUNT = BASE_URL + "auth/delete-account"
    static let CHECK_CODE = BASE_URL + "auth/check-verification-code"
    static let RESEND_CODE = BASE_URL + "auth/resend-verification-code"
    static let FORGOT_PASSWORD = BASE_URL + "auth/forgot-password"
    static let RESET_PASSWORD = BASE_URL + "auth/reset-password"
    static let USER_INFO = BASE_URL + "auth/user-info"
}

class Storage {
    public var accessToken: String = ""
    
    static let sharedInstance = Storage()
}
