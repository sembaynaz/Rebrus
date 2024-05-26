//
//  Patient.swift
//  Rebrus
//
//

import Foundation
struct Patient {
    let fullName: String
    let moca: Double
    let mmse: Double
    let hads: Double
    let hars: Double
    let miniCog: Double
    let gender: String
    let dob: String         // date of birth
    let phoneNumber: String
    let address: String
    let region: String
    let date: String
    let doctorName: String
    
    let level: Int // level of illness
}

struct DementiaLevel {
    let level: Int
    let title: String
    let emoji: String
}

struct PatientCellData {
    let title: String
    let cellType: PatientDataCellType
}

enum PatientDataCellType {
    case gender
    case dob
    case address
    case region
    case phoneNumber
    case date
    case doctor
    case moca
    case mmse
    case hads
    case hars
    case miniCog
}



class PatientDataViewModel {
    private var items: [PatientCellData] = []
    private var levels = [
        DementiaLevel(level: 0, title: "Неизвестная", emoji: "🤥"),
        DementiaLevel(level: 1, title: "Нет деменции", emoji: "🙂"),
        DementiaLevel(level: 2, title: "Раняя", emoji: "🤔"),
        DementiaLevel(level: 3, title: "Средняя", emoji: "😐"),
        DementiaLevel(level: 4, title: "Поздняя", emoji: "😬"),
    ]
    
    var cellData: [PatientCellData] {
        return items
    }
    
    init() {
        items = [
            PatientCellData(title: "Пол", cellType: .gender),
            PatientCellData(title: "День рождения", cellType: .dob),
            PatientCellData(title: "Номер телефона", cellType: .phoneNumber),
            PatientCellData(title: "Адрес", cellType: .address),
            PatientCellData(title: "Регион", cellType: .region),
            PatientCellData(title: "Дата приёма", cellType: .date),
            PatientCellData(title: "Ответственный", cellType: .doctor),
            PatientCellData(title: "MoCA", cellType: .moca),
            PatientCellData(title: "MMSE", cellType: .mmse),
            PatientCellData(title: "HADS", cellType: .hads),
            PatientCellData(title: "HARS", cellType: .hars),
            PatientCellData(title: "Mini-Cog", cellType: .miniCog)
        ]
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> PatientCellData {
        return items[index]
    }
    
    func getDementiaLevel(by id: Int) -> DementiaLevel? {
        return levels.first { $0.level == id }
    }
}
