import UIKit

// properties
struct Person {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let lets = Person(clothes: "All black", shoes: "Red Vans")
let other = Person(clothes: "Dont know", shoes: "Dont Care")

lets.describe()
other.describe()

// willSet, didSet
struct Person2 {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I've changed from \(oldValue) to \(clothes)")
        }
    }
    
    func updateUI(msg: String) {
        print(msg)
    }
}

var lets2 = Person2(clothes: "All Black")

lets2.clothes = "M65 Fishtail"


// computed properties
struct Person3 {
    var age: Int
    
    var ageInDogYears: Int {
        get { // 그냥 데이터를 가져올때만 사용하려면 get {} 을 뺀다
            return age * 7
        }
    }
}

var doggy = Person3(age: 25)
print(doggy.ageInDogYears)


// static properties and methods
// 한 type 안에서 share 되는 property 를 만드는것
struct cnemaFan {
    static var favoriteSong = "Far Away"
    
    var name: String
    var age: Int
}


let fan = cnemaFan(name: "Lets", age: 25)
print(cnemaFan.favoriteSong)

cnemaFan.favoriteSong = "MobyDick" // static 은 struct 에서 공유되는것이기 때문에 instance 에서 바꿔주는게 아니라 struct 자체에서 바꿔줘야함
print(cnemaFan.favoriteSong)


// access control
// public: 모두가 해당 data 를 읽고 쓸 수 있음
// internal: 나의 Swift Code 만 data 를 읽고 쓸 수 있음, 만약 이 코드를 다른곳에서 읽고 쓸려고 하면 불가능
// file private: 같은 file 내의 swift code 만 이 property 를 읽고 쓸 수 있음
// private: 해당 type 의 methods 혹은 extension 에서만 읽고 쓰여질 수 있음

class cnemaFan2 {
    private var name: String?
}


// polymorphism == 다형성
// super 와 같은 이름으로도 다른일을 할 수 있는것
class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}


class studioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class liveAlbum: Album {
    var location: String
    
    init (name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var cnema = Album(name: "Far Away")
var taylorSwift = studioAlbum(name: "Taylor Swift", studio: "The castle Studio")
var fearless = studioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = liveAlbum(name: "iTunes Live from SoHo", location: "New York")
var allAlbums: [Album] = [cnema, taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}


// typecasting
// 1. as? == optional downcasting
// -> 어떤 type 의 object 를 이렇게 다루는게 가능할수도 불가능할수도 있다

// 2. as! == force downcasting
// -> 되든 안되든 일단 이렇게 다루고, 불가능하면 앱 crash

for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? studioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? liveAlbum {
            print(liveAlbum.location)
    } else {
        print("\(album.name) is neither studio or live album.")
    }
}

let number = 5
let text = number as? Int
print(text)


// closures -> code 를 저장해두는 변수
// closure 는 환경을 저장하기도 함
// trailing closure syntax 도 생각

let vw = UIView() // 저장할 환경

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0 // -> 저장한 환경 사용
})
