//
//  User.swift
//  Rebrus
//
//

import Foundation

struct ProfileData {
    let title: String
    let subtitle: String
}

struct User: Codable {
    var email: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var birthDate: String?
    var gender: String?
    var region: String?
    var avatarUrl: String?
}
