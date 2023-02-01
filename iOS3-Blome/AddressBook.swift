//
//  main.swift
//  iOS3-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import Foundation

class AddressBook: Codable {
    var addressCards: [AddressCard]
    
    init() {
        addressCards = []
    }
    
    func add(card: AddressCard) {
        self.addressCards.append(card)
    }
    
    func remove(card: AddressCard) {
        if let cardToRemove = self.addressCards.firstIndex(of: card) {
            self.addressCards.remove(at: cardToRemove)
        }
        
        // Removing all "friends" references to this card
        for otherCard in addressCards {
            otherCard.remove(friend: card)
        }
    }
    
    func sortCards() {
        self.addressCards.sort(by: {$0.lastName < $1.lastName})
    }
    
    func getCardByName(name: String) -> AddressCard? {
        return self.addressCards.first(where: {$0.lastName == name})
    }
    
    func getCardById(id: UUID) -> AddressCard? {
        return self.addressCards.first(where: {$0.id == id})
    }

    func friendsOf(card: AddressCard) -> [AddressCard] {
        var friendCards: [AddressCard] = []
        
        for friendId in card.friends {
            if let friendCard = getCardById(id: friendId) {
                friendCards.append(friendCard)
            }
        }
        
        return friendCards
    }
    
    func save(toFile path: String) {
        let path = "book.json"
        let url = URL(fileURLWithPath: path)
        
        // Encode and save
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            try? data.write(to: url)
        }
    }
    
    class func createAddressBook(fromFile path: String) -> AddressBook? {
        let url = URL(fileURLWithPath: path)
        
        // Read and decode
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let book = try? decoder.decode(AddressBook.self, from: data) {
                return book
            }
        }
        
        return nil
    }
}
