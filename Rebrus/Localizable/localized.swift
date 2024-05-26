//
//  localized.swift
//  Rebrus
//
//

import Foundation

enum LocalizableTable: String {
    case main = "Main"
    case auth = "SignIn"
    case onboard = "Onboarding"
}

extension String {
    
    func localized(from table: LocalizableTable) -> String {
            let language = MTUserDefaults.shared.language.getLocalizationLanguage()
            guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
                  let bundle = Bundle(path: path) else {
                return NSLocalizedString(self, comment: self)
            }
            
            return NSLocalizedString(self, tableName: table.rawValue, bundle: bundle, value: self, comment: self)
        }
    
    func localized(with text: String, from table: LocalizableTable) -> String {
        let language = MTUserDefaults.shared.language.getLocalizationLanguage()

        
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return String.localizedStringWithFormat(NSLocalizedString(self, comment: self))
        }
        
        return String.localizedStringWithFormat(
            NSLocalizedString(self, tableName: table.rawValue, bundle: bundle, value: self, comment: self),
            count
        )
    }
    
    
    func localized(withAdditionalString additionalString: String) -> String {
            let language = MTUserDefaults.shared.language.getLocalizationLanguage()
            guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
                  let bundle = Bundle(path: path) else {
                return NSLocalizedString(self, comment: self)
            }
            let localizedString = NSLocalizedString(self, tableName: "Onboarding", bundle: bundle, value: self, comment: self)
            
            let stringWithAdditionalString = localizedString.replacingOccurrences(of: "%@", with: additionalString)
            
            return stringWithAdditionalString
        }
}
