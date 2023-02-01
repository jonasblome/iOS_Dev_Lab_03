//
//  main.swift
//  iOS3-Blome
//
//  Created by  on 28.01.23.
//

import Foundation

// initialize the Command Line Interface
var cli = CLI()

// control flow variable
var running = true

while running {
    print("(E)ingabe, (S)uche, (L)iste oder (Q)uit?")
    
    if let command = readLine() {
        if command == "E" || command == "e" {
            cli.entry()
        } else if command == "S" || command == "s" {
            cli.search()
        } else if command == "L" || command == "l" {
            cli.list()
        } else if command == "Q" || command == "q" {
            running = false
        } else {
            print("Please enter a valid command")
        }
    }
}

class CLI {
    var book: AddressBook
    
    init() {
        if let fromJson = AddressBook.adressBook(fromFile: "book.json") {
            self.book = fromJson
        }
        else {
            self.book = AddressBook()
        }
    }
    
    func entry() {
        var firstName = ""
        var lastName = ""
        var street = ""
        var postalCode = 0
        var city = ""
        var hobbies: [Hobby] = []
        let friends: [UUID] = []
        
        print("Create new contact card:")
        
        print("First Name:" )
        if let name = readLine() {
            firstName = name
        }
        
        print("Last Name: ")
        if let name = readLine() {
            lastName = name
        }
        
        print("Street: ")
        if let newStreet = readLine() {
            street = newStreet
        }
        
        print("Postal Code: ")
        if let newPostalCode = readLine() {
            if let pCInt = Int(newPostalCode) {
                postalCode = pCInt
            }
            else {
                postalCode = 0
            }
        }
        
        print("City: ")
        if let location = readLine() {
            city = location
        }
        
        // Control flow variable
        var hobbyRunning = true

        while hobbyRunning {
            print("Hobby: (Cancel with (Q))")
            if let command = readLine() {
                if command == "Q"{
                    hobbyRunning = false
                } else {
                    let newHobby = Hobby(name: command)
                    hobbies.append(newHobby)
                }
            }
        }
        
        // Creating address cord
        let card = AddressCard(firstName: firstName, lastName: lastName, street: street, postalCode: postalCode, city: city, hobbies: hobbies, friends: friends)
        
        // Add to book
        self.book.addressCards.append(card)
        
        self.book.save(toFile: "book.json")
    }

    func search() {
        print("Search for name: ")
        
        if let searchName = readLine() {
            if let addressCard = self.book.getCardByName(name: searchName) {
                printCard(card: addressCard)
            }
            else {
                print("No friend was found")
            }
        }
    }

    func list() {
        for card in self.book.addressCards{
            printCard(card: card)
        }
    }
    
    func printCard(card: AddressCard) {
        print("+----------------")
        print("| " + card.firstName + " " + card.lastName)
        print("| " + card.street)
        print("| " + String(card.postalCode) + " " + card.city)
        print("| " + "Hobbies:")
        
        for hobby in card.hobbies {
            print("|     " + hobby.name)
        }
        
        print("| " + "Friends:")
        
        for friendID in card.friends {
            if let friend = self.book.getCardById(id: friendID){
                let friendName = friend.firstName + " " + friend.lastName
                print("|     " + friendName)
            }
        }
    }
}



    

