//
//  Info.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import Foundation

enum Section: CaseIterable {
    case info, location
    
    var rows: [SectionRow] {
        switch self {
        case .info:
            return Info.allCases
        case .location:
            return Locations.allCases
        }
    }
}

enum Info: CaseIterable, SectionRow {
    case species, gender, status
    
    var row: Row {
        switch self {
        case .species:
            return Row(title: "Species", icon: "hare")
        case .gender:
            return Row(title: "Gender", icon: "eyes")
        case .status:
            return Row(title: "Status", icon: "waveform.path.ecg.rectangle")
        }
    }
}

enum Locations: CaseIterable, SectionRow {
    case location, origin
    
    var row: Row {
        switch self {
        case .location:
            return Row(title: "Location", icon: "map")
        case .origin:
            return Row(title: "Origin", icon: "location")
        }
    }
}
