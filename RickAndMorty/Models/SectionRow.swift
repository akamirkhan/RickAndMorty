//
//  SectionRow.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 28.01.2023.
//

import Foundation

protocol SectionRow {
    var row: Row { get }
}

struct CharacterRow: SectionRow {
    var row: Row
}

struct Row {
    let title: String
    let icon: String
}
