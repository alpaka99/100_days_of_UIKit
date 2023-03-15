import UIKit

// functions

func favoriteAlbum(name: String) {
    print("My favorite is \(name)")
}

favoriteAlbum(name: "Mobydick")
favoriteAlbum(name: "Fearless")


func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}
printAlbumRelease(name: "Mobydick", year: 2022)

func countLetters(of string: String) { // 자연스럽게 읽히는 swift 식의 문법
    print("The string \(string) has \(string.count) letters.")
}

countLetters(of: "Hello")

let songs = ["A", "B", "C"]
func isTaylorSwiftSong(_ name: String) -> Bool {
    if songs.contains(name) {
        return true
    } else {
        return false
    }
}

isTaylorSwiftSong("A")
isTaylorSwiftSong("a")


// optionals
func getHaterStatus(weather: String) -> String? {
    if weather == "Gloomy" {
        return "Hate"
    } else {
        return nil
    }
}

var status: String
if let status = getHaterStatus(weather: "Gloomy") {
    print(status)
} else {
    print("Too good day to hate")
}

var items = ["James", "Nox", "Alpha", "Havi"]

func position(of string: String, in array: [String]) -> Int? {
    for i in 0..<items.count {
        if items[i] == string {
            return i
        }
    }
    
    return nil
}

let jamesPosition = position(of: "James", in: items)
let noxPosition = position(of: "Nox", in: items)
let alphaPosition = position(of: "Alpha", in: items)
let haviPosition = position(of: "Havi", in: items)
let maxPosition = position(of: "Max", in: items)

if maxPosition == nil {
    print("Cannot find Max")
} else {
    print("This person is \(maxPosition!)")
}

var name = "Havi"
var name2: String? = "Alpha"
var name3: String? = "Nox"

print("\(name), \(name2), \(name3!)")


// optional chaining
var nickname: String? = "Alpha"
nickname?.uppercased()
nickname?.count

// nil coalescing
var nilCoalescning: String? = nil

print(nilCoalescning ?? "It's nil")

// Enumerations
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
//    if weather == .sun {
//        return nil
//    } else {
//        return "Hate"
//    }
    
//    switch weather {
//    case .sun:
//        return nil
//    case .wind, .cloud:
//        return "Dislike"
//    case .rain:
//        return "Hate"
//    case .snow:
//        return "soso"
//    }
    
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: .wind(speed: 9))


// structs
struct Person {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}


let lets = Person(clothes: "Hoody", shoes: "Powder Blue")
let others = Person(clothes: "Normal clothes", shoes: "Normal shoes")

print(lets.clothes)

var letsCopy = lets
letsCopy.shoes = "RedVans"

print(lets.shoes)
print(letsCopy.shoes)

lets.describe()
others.describe()


// classes
// struct 와 차이점
// 1. init 메서드가 자동으로 생성되지 않는다
// 2. 다른 클래스를 기반으로 몇가지를 더한 새로운 클래스를 생성할 수 있다 -> Inheritance (CoCoa touch 에서 굉장히 자주 사용됨)
// 3. 클래스의 instance 는 object 라고하며, instance 들은 서로 연동이 된다

class Persons {
    var clothes: String
    var shoes: String
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
    
    func describe() {
        print("I am wearing \(clothes) with \(shoes)")
    }
}

let letz = Persons(clothes: "hoody", shoes: "AirJordan")
let letzCopy = letz

letz.shoes = "Vans"

letz.describe()
letzCopy.describe()

class Singer {
    var name: String
    var age: Int
        
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("La La La")
    }
}

let cnema = Singer(name: "Cnema", age: 25)
cnema.sing()

class CountrySinger: Singer {
    override func sing() {
        print("Country folk song")
    }
}

var John = CountrySinger(name: "John", age: 30)
John.sing()


class HeavyMetalSinger: Singer {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }
        
    override func sing() {
            print("Kyaaaaaaa!!!")
    }
}

let lim = HeavyMetalSinger(name: "Lim yoonsung", age: 25, noiseLevel: 8)
lim.sing()
