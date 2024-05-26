//
//  User.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 21/05/2024.
//

import Foundation

struct ProfileData {
    let title: String
    let subtitle: String
}

struct User {
    let name: String
    let surname: String
    let fatherName: String
}


struct UserCellData {
    let title: String
    let placeholder: String
}

class UserDataViewModel {
    private var items: [UserCellData] = []
    
    var cellData: [UserCellData] {
        return items
    }
    
    init() {
        items = [
            UserCellData(title: "Фамилия", placeholder: "Иванов"),
            UserCellData(title: "Имя", placeholder: "Иван"),
            UserCellData(title: "Отчество",  placeholder: "Иванович")
        ]
    }
    
  
}
