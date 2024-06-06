//
//  Configurations.swift
//  Rebrus
//
//

import Foundation
struct Configuration {
    static let AUTH_SERVICE = "http://167.71.48.186:8000/api/auth-service/"
    
    static let SIGN_IN_URL = AUTH_SERVICE + "auth/login"
    static let SIGN_UP_URL = AUTH_SERVICE + "auth/register"
    static let DELETE_ACCOUNT = AUTH_SERVICE + "auth/delete-account"
    static let CHECK_CODE = AUTH_SERVICE + "auth/check-verification-code"
    static let RESEND_CODE = AUTH_SERVICE + "auth/resend-verification-code"
    static let FORGOT_PASSWORD = AUTH_SERVICE + "auth/forgot-password"
    static let RESET_PASSWORD = AUTH_SERVICE + "auth/reset-password"
    static let USER_INFO = AUTH_SERVICE + "auth/user-info"
    static let UPDATE_USER_INFO = AUTH_SERVICE + "auth/update-profile"
    
    
    static let UPLOAD_PHOTO = "http://167.71.48.186:8084/image"
    
    
    static let PATIENT_SERVICE = "http://167.71.48.186:8000/api/patient-service/"
    
    static let GET_PATIENTS = PATIENT_SERVICE + "patient-management/patients"
    static let PATIENT_DETAILS = PATIENT_SERVICE + "patient-management/patient/"
}

class Storage {
    public var accessToken: String = ""
    
    static let sharedInstance = Storage()
}
