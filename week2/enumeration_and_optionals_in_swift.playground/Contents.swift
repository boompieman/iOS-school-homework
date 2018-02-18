//: Playground - noun: a place where people can play

import UIKit


//1.

//1.1
enum Gasoline {
    case gasoline92
    
    case gasoline95
    
    case gasoline98
}

//1.2
func getPrice(gas: Gasoline) -> Double {
    switch gas {
    case Gasoline.gasoline92: return 92.01
    case Gasoline.gasoline95: return 95.01
    case Gasoline.gasoline98: return 98.01
    }
}

getPrice(gas: Gasoline.gasoline92)

//2

//2.1
class Pet {
    var name: String
    init (name: String) {
        self.name = name
    }
}

class People {
    var pet: Pet?
}

//guard let
let person = People()
person.pet = Pet(name: "Cash")
//person.pet = nil

func makeSurePet(person:People) ->String {
    guard let pet1 = person.pet else {
        return "I don't have a pet"
    }
    return "\(pet1.name) is my pet"
}

print(makeSurePet(person: person))


//if let
let person2 = People()
person2.pet = nil

if let pet2 = person2.pet{
    print("\(pet2.name) is my pet")
} else {
    print("I don't have a pet")
}


