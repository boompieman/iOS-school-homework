//: Playground - noun: a place where people can play

import UIKit


//1.

enum Gender {
    case male
    
    case female
    
    case undefined
}

class Animal {
    
    let gender: Gender
    
    init() {
        self.gender = Gender.undefined
    }
    
    init(gender: Gender) {
        self.gender = gender
    }
    
    
    func eat () {
        print("I eat Everything")
    }
}

//2.

class Elephant: Animal {
    override func eat() {
        print("I eat fruit")
    }
}

let elephant = Elephant(gender: Gender.male)
elephant.eat()

class Tiger: Animal {
    override func eat() {
        print("I eat meats")
    }
}
let tiger = Tiger()
tiger.eat()


class Horse: Animal {
    override func eat() {
        print("I eat grasses")
    }
}

let horse = Horse()
horse.eat()

//3.

class Zoo {
    
    var weeklyHot:Animal
    
    init (weeklyHot: Animal) {
        self.weeklyHot = weeklyHot
    }
    
    init () {
        self.weeklyHot = Tiger()
    }
}

let zoo = Zoo()

zoo.weeklyHot = horse
zoo.weeklyHot
zoo.weeklyHot = elephant
zoo.weeklyHot
