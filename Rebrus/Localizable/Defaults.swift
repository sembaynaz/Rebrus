//
//  Defaults.swift
//  Rebrus
//
//

import Foundation
enum Language: Int {
    case ru
    case kz
    case en
    
    func getLocalizationLanguage() -> String {
        switch self {
        case .ru:
            return "ru"
        case .kz:
            return "kk-KZ"
        case .en:
            return "en"
        }
    }
    
    func getLanguageFullName() -> String {
        switch self {
        case .ru:
            return "Русский язык"
        case .kz:
            return "Қазақ тілі"
        case .en:
            return "English"
        }
    }
}

struct MTUserDefaults {
    
    static var shared = MTUserDefaults()

    
    var language: Language {
        get {
            Language(rawValue: UserDefaults.standard.integer(forKey: "selectedLanguage")) ?? .ru
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedLanguage")
        }
    }
}
