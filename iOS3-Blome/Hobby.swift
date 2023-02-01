//
//  main.swift
//  iOS3-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import Foundation


func == (left: Hobby, right: Hobby) -> Bool {
    return left.id == right.id
}

class Hobby: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    
    init(name: String) {
        id = UUID()
        self.name = name
    }
}
