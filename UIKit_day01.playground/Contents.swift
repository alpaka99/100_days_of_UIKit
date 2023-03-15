import UIKit

// types
var name: String
name = "Go"

var age: Int
age = 10

var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -186.783333


var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = false

var missABeat: Bool
missABeat = stayOutTooLate && nothingInBrain

var missAClass: Bool
missAClass = stayOutTooLate || nothingInBrain

// type inferences
var name2 = "What should I use for my name?"
var double1 = -186.3333333
print(type(of: double1))


// operators
var a = 1.1
var b = 2.2
var c = a + b

var n1 = "Havi"
var n2 = "Go"
var both = n1 + n2

var remain = 10 % 3

var ga = 1.1
var gb = 2.2
var gc = 3.3

gc > gb
ga > gb
gc > 4
gc < 4

n1 == "Havi"

var drinkTooMuch = false
drinkTooMuch
!drinkTooMuch
drinkTooMuch != false

// string interpolation == combining variable and constatns in string
var nickname = "Alpha"
var na = 25
var nlatitudde = 36.1666667
"Your nickname is \(nickname). Your age is \(na). Your latitude is \(nlatitudde)"



// arrays
var evennumbers = [2, 4, 6, 8]
var songs: [Any] = ["On the street", "D", "Dynamite", "Mobydick", 3] // 다양한 type 을 하나의 array 에 넣고싶으면 Any type 의 array 라고 특정해줘야함

songs[0]
songs[1]
songs[2]
songs[3]


type(of:songs)

var nsongs = [String]()
nsongs.append("Piano man")

var both_songs = songs + nsongs
both_songs += ["Legends never die"]
both_songs.append("Queens and Kings")
print(both_songs)


// dictionaries
var nickname_dict = [
    "Elcap": "Male",
    "Shannon": "Female",
    "Soda": "Female",
    "Lets": "Female"
]

nickname_dict["Soda"]

// conditional statements
var action: String
var person_action = "player"

if person_action == "hater" {
    action = "hate"
} else if person_action == "player"{
    action = "play"
} else {
    action = "cruise"
}

// loops
for i in (0..<10) {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"
for _ in 0..<5 {
    str += " fake"
}
print(str)

for i in 0..<both_songs.count {
    print("Songs in my list are \(both_songs[i])")
}

var counter = 0

while counter <= 1005 {
    counter += 1
    print("Counter is now \(counter)")
}

// switch case -> case 가 exhaustive 해야함
let liveALbums = 2

switch liveALbums {
case 0..<1: // range 로도 범위를 지정 가능함
    print("You are just starting out")
    
case 1:
    print("You just released iTunse Live From Soho")
    
case 2:
    print("You've became a legend mate")

default:
    print("Have you done something new?")
}
