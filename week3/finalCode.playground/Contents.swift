//: Playground - noun: a place where people can play

import Foundation
import GameKit

enum CodeSelection : String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case cancel = "取消"
    case submit = "送出"
}

var dictionary: [CodeSelection:String] = [.one:"1"]

enum FinalCodeError: Error {
    case invalidNumber
    case invalidSelection
}

protocol FinalCode{
    var target: Int { get set }
    var selection: [CodeSelection] { get }
    var lastSelect:Int { get set }
    
    init()
    
    func enterNumber(selection: CodeSelection?) throws -> String
    func compare(of finalSelectNumber:Int?) throws -> String
}


class FinalCodeImplement: FinalCode {
    var lastSelect: Int = 0
    var target: Int
    
    let selection: [CodeSelection] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .cancel, .submit]
    
    required init() {
        target = GKRandomSource.sharedRandom().nextInt(upperBound: 100)+1
    }
    
    func enterNumber(selection: CodeSelection?) throws -> String {
        
        guard let eachSelect = selection else {
            throw FinalCodeError.invalidSelection
        }
        return eachSelect.rawValue
    }
    
    
    //return to alert
    func compare(of finalSelectNumber:Int?) throws -> String {
        
        guard let final = finalSelectNumber else{
            throw FinalCodeError.invalidNumber
        }
        
        if final == target {
            return "目標已被選到"
        }
        
        if lastSelect == 0 {
            if target < final {
                return "目標在 0 ~ \(final)"
            }
            
            if target > final  {
                return "目標在\(final) ~ 100"
            }
        }
        else {
            if target < final && target > lastSelect {
                return "目標在\(lastSelect) ~ \(final)"
            }
            if target > final && target < lastSelect {
                return "目標在\(final) ~ \(lastSelect)"
            }
        }
        return "請輸入正確數字"
    }
}

var finalCode = FinalCodeImplement()

finalCode.target
finalCode.lastSelect = 95

do {
    try finalCode.compare(of: 20)
} catch FinalCodeError.invalidNumber {
    print("invalid Number")
}

//var currentSelection: CodeSelection?
//
//currentSelection = .one
//
//do {
//    try finalCode.enterNumber(selection: currentSelection)
//} catch FinalCodeError.invalidSelection {
//    print("invalid Selection")
//}






