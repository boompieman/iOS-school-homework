//: Playground - noun: a place where people can play

import UIKit

/*-----
 array
-----*/

//1.

var myFriends: [String] = []

//2.

myFriends.append("Ian")
myFriends += ["Bomi"]
myFriends.insert("Kevin", at: 2)

//3.

myFriends.append("Michael")

//4.

myFriends.swapAt(2, 0)

//5.

/*------------
 the first way
------------*/
myFriends.forEach { friend in
    print(friend)
}

/*-------------
 the second way
-------------*/
for friend in myFriends {
    print(friend)
}

//6.

//print(myFriends[5]) error: index out of range
/*
 no one in the index 5 of myFriends array, and it is out of range because there are only 4 people in the list. That's why we cannot get any answer.
*/



/*-----
 Dictionary
 -----*/

//1.

var MyCountryNumber: [String:Int] = [:]

//2.

MyCountryNumber["US"] = 1
MyCountryNumber.updateValue(44, forKey: "GB")
MyCountryNumber["JP"] = 81

//3.

MyCountryNumber["US"] = nil
// or
MyCountryNumber.removeValue(forKey: "US")

//4.
MyCountryNumber["GB"] = 0

//5.

let country = Array(MyCountryNumber.keys)
let countryNumber = Array(MyCountryNumber.values)


/*-----------------
 For, While, Repeat
-----------------*/

//1.
for friend in myFriends {
    print(friend)
}

for (key, value) in MyCountryNumber{
    print("\(key): \(value)")
}

//2.
let lottoNumbers = [10,9,8,7,6,5]

for i in lottoNumbers.count-3...lottoNumbers.count-1 {
    print(lottoNumbers[i])
}

//3.

for i in 5...10{
    print(i)
}

for i in stride(from: 10, through: 6, by: -2) {
    print(i)
}

//4.

var count1:Int = 5
while count1 <= 10 {
    print(count1)
    count1+=1
}

var count2:Int = 10
while count2 >= 6 {
    print(count2)
    count2 -= 2
}

//5.

var count3: Int = 5
repeat {
    print(count3)
    count3 += 1
} while count3 <= 10

var count4: Int = 10
repeat {
    print(count4)
    count4 -= 2
} while count4 >= 6


/*------------
 If statement
 -----------*/

//1.
var isRaining:Bool = true

if isRaining {
    print("It’s raining, I don’t want to work today.")
}
else {
    print("Althoughit’s sunny, I still don’t want to work today.")
}


/*------
 Switch
------*/

var jobLevel: Int = 3

switch jobLevel {
    case 1: print("Present Member")
    case 2: print("Team Leader")
    case 3: print("Manager")
    case 4: print("Director")
    default: print("We don't have this job!")
    break
}
