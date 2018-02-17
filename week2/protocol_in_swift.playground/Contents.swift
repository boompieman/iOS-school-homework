//: Playground - noun: a place where people can play

import UIKit


//1.

protocol PoliceMan {
    func arrestCriminals()
}

//2.

struct Person: PoliceMan {
    var name: String
    func arrestCriminals() {

    }
}

//3.
protocol ToolMan {
    func fixComputer()
}

//4.
struct Person2: PoliceMan, ToolMan {
    var name: String
    var toolMan: ToolMan
    func arrestCriminals() {
        
    }
    
    func fixComputer() {
        
    }
}

//5.
struct Engineer: ToolMan {
    func fixComputer() {
        
    }
}

//6.

let person = Person(name:"Steven")

