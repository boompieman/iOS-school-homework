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


let person = People()
person.pet = Pet(name: "Cash")
//person.pet = nil


//guard let pet1 = People().pet else {
//    print("pet is empty")
//    return
//}
//print(pet1.name)
let person2 = People()
person2.pet = nil

if let pet2 = person2.pet, pet2 == nil {
    print("pet is not exist")
} 
//    print(person2.pet?.name)
//}

print("exit")


