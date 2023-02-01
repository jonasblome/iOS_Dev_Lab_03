//
//  main.swift
//  iOS3-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import Foundation

func == (left: AddressCard, right: AddressCard) -> Bool {
    return left.id == right.id
}

class AddressCard: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var firstName: String
    var lastName: String
    var street: String
    var postalCode: Int
    var city: String
    var hobbies: [Hobby]
    var friends: [UUID]
    
    init() {
        id = UUID()
        firstName = ""
        lastName = ""
        street = ""
        postalCode = 0
        city = ""
        hobbies = []
        friends = []
    }
    
    init(firstName: String, lastName: String, street: String, postalCode: Int, city: String, hobbies: [Hobby], friends: [UUID]) {
        id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.postalCode = postalCode
        self.city = city
        self.hobbies = hobbies
        self.friends = friends
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func add(hobby: Hobby) {
        self.hobbies.append(hobby)
    }
    
    func remove(hobby: Hobby) {
        if let hobbyToRemove = self.hobbies.firstIndex(of: hobby) {
            self.hobbies.remove(at: hobbyToRemove)
        }
    }
    
    func add(friend: AddressCard) {
        self.friends.append(friend.id)
    }
    
    func remove(friend: AddressCard) {
        if let friendToRemove = self.friends.firstIndex(of: friend.id) {
            self.friends.remove(at: friendToRemove)
        }
    }
}
