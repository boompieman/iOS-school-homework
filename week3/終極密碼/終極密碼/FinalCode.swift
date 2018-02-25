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
    var maxNumber: Int { get set }
    var minNumber: Int { get set }
    var isRightNumber: Bool { get set }
    
    init()
    
    func enterNumber(selection: CodeSelection?) throws -> String
    func compare(of finalSelectNumber:Int?) throws -> String
    func isTarget(of finalSelectNumber:Int?) -> Bool
}


class FinalCodeImplement: FinalCode {
    
    var maxNumber: Int = 100
    var minNumber: Int = 0
    var target: Int
    var isRightNumber: Bool = true
    
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
    
    func isTarget(of finalSelectNumber:Int?) -> Bool {
        if finalSelectNumber == target {
            return true
        }
        else{
            return false
        }
    }
    
    
    //return to alert
    func compare(of finalSelectNumber:Int?) throws -> String {
        
        guard let final = finalSelectNumber else{
            throw FinalCodeError.invalidNumber
        }
        
        if final == target {
            return "Game Over"
        } else if final < target && final < maxNumber && final > minNumber {
            minNumber = final
            return "\(minNumber) ~ \(maxNumber)"
        } else if final > target && final < maxNumber && final > minNumber {
            maxNumber = final
            return "\(minNumber) ~ \(maxNumber)"
        }
        
        return "請輸入\(minNumber) ~ \(maxNumber)"
    }
}
