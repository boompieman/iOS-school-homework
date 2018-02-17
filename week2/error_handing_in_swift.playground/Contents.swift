//: Playground - noun: a place where people can play

import UIKit


//1.

enum GuessNumberGameError: Error {
    case wrongNumber
}

class GuessNumerGame {
    var targetNumber = 10
    func guess(number: Int) throws {
        guard number == targetNumber else {
            throw GuessNumberGameError.wrongNumber
        }
        
        print("Guess the right number: \(targetNumber)")
    }
}


//2.

do {
 try GuessNumerGame().guess(number: 20)
} catch GuessNumberGameError.wrongNumber {
    print("number is not 10")
}

