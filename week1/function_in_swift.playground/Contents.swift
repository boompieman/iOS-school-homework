//: Playground - noun: a place where people can play

import UIKit
import GameKit


//1.

func greet(person: String) -> String {
    return "Hello " + person
}

greet(person: "Celeste")

//2.

func multiply(_ a: Int, b: Int = 10) {
    print(a*b)
}
multiply(5)
multiply(5, b:2)


