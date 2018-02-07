//: Playground - noun: a place where people can play

import UIKit


// 1.

let pi: Double = 3.14 // we think pi is a constant number = 3.14

// 2.

let x:Int = 5
let y:Int = 26

let average = (x * y)/2

//3.

let xFloat = Float(x)
let yFloat = Float(y)
let newAverage = (xFloat * yFloat)/2
let result = NSString(format:"%.1f",newAverage)

/*
 because 10 is type of integer, and 3 is also interger, the result will automatically integer, which is 3.
 But what if 10 divided by 3.0 is different, because 3.0 is type of Double(Float), so compiler will regard 10 as Double(Flaot), too. And the result would be 3.333.....
*/
 
10/3
10/3.0

//4.

var flag = true // Boolean
var inputString = "Hello world" // String
let bitsInBite = 8 // Integer
let avergeScore = 86.8 // Double

type(of:avergeScore)

//5.

var salary: Int = 22000
salary += 28000

//6.

0 == false

//7.

let divisor:Int = 3
let divident: Int = 10

let remain: Int = 10%3
