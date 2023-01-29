//
//  EpisodeInfo.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 27.01.2023.
//

import Foundation

enum Sections: Equatable {
    case info, characters(characters: [CharacterRow])
    
    var title: String {
        switch self {
        case .info:
            return "Info"
        case .characters:
            return "Characters"
        }
    }
    
    var rows: [SectionRow] {
        switch self {
        case .info:
            return Information.allCases
        case .characters(let characters):
            return characters
        }
    }
    
    static func == (lhs: Sections, rhs: Sections) -> Bool {
        lhs.title == rhs.title
    }

}

enum Information: CaseIterable, SectionRow {
    case name, data, code
    
    var row: Row {
        switch self {
        case .name:
            return Row(title: "Name", icon: "info")
        case .data:
            return Row(title: "Air date", icon: "calendar")
        case .code:
            return Row(title: "Code", icon: "barcode")
        }
    }
}
