//
//  Patient.swift
//  Rebrus
//
//

import Foundation

struct Assessments: Codable {
    var type: String
    var points: Int
}

struct Note: Codable {
    var modifiedDate: String?
    var value: String?
    var modifiedBy: String?
}

struct Appointment: Codable {
    var date: String
}

struct File: Codable {
    var name: String
    var type: String
    var url: String
    var size: String
}

struct Patient: Codable {
    var iin: String
    var gender: String
    var id: Int
    var middleName: String
    var phone: String
    var firstName: String
    var appointments: [Appointment]
    var passedQuizzes: [String]
    var createdBy: Int
    var note: Note
    var responsible: String
    var address: String
    var createdDate: String
    var stageOfDementia: Level
    var region: String
    var lastName: String
//    var files: [File]
    var birthDate: String
    var assessments: [Assessments]
}

struct PatientsResponse: Codable {
    var empty: Bool
    var content: [Patient]
    var totalPages: Int
    var size: Int
    var first: Bool
    var pageable: Pageable
    var last: Bool
    var number: Int
    var sort: [Sort]
    var totalElements: Int
    var numberOfElements: Int
}

struct Pageable: Codable {
    var sort: [Sort]
    var pageNumber: Int
    var pageSize: Int
    var offset: Int
    var paged: Bool
    var unpaged: Bool
}

struct Sort: Codable {
    var property: String
    var nullHandling: String
    var ignoreCase: Bool
    var direction: String
    var ascending: Bool
    var descending: Bool
}

struct DementiaLevel {
    let level: Level
    let title: String
    let emoji: String
}

enum Level: String, Codable {
    case unknown = "UNKNOWN"
    case noDementia = "NO_DEMENTIA"
    case suspected = "SUSPECTED"
    case early = "EARLY"
    case middle = "MIDDLE"
    case late = "LATE"
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
        DementiaLevel(level: .unknown, title: "Неизвестная", emoji: "🤥"),
        DementiaLevel(level: .noDementia, title: "Нет деменции", emoji: "🙂"),
        DementiaLevel(level: .early, title: "Раняя", emoji: "🤔"),
        DementiaLevel(level: .middle, title: "Средняя", emoji: "😐"),
        DementiaLevel(level: .late, title: "Поздняя", emoji: "😬"),
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
            PatientCellData(title: "Ответственный", cellType: .doctor)
        ]
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> PatientCellData {
        return items[index]
    }
    
    func getDementiaLevel(by id: Level) -> DementiaLevel? {
        return levels.first { $0.level == id }
    }
}
