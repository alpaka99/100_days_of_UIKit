import UIKit

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)")
}

print(name[name.index(name.startIndex, offsetBy: 3)])


extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

print(name[3])

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("456")

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    func withPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) == false else { return self }
        return prefix + self
    }
}

let noPrefix = "pet"
let withPrefix = noPrefix.withPrefix("car")
print(withPrefix)

print(password.deletingPrefix("123"))
print(password.deletingSuffix("345"))


let weather = "it's going to rain"

print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}


let input = "Swift is like Objective-C without C"
input.contains("Swift")


let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        
        return false
    }
}


input.containsAny(of: languages)

languages.contains(where: input.contains)


let string = "This is a test string"

let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)

print(attributedString)


let mutableAttributedString = NSMutableAttributedString(string: string)

mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))



extension String {
    func containsNumeric() -> Bool {
        for letter in self {
            if letter.isNumber {
                return true
            }
        }
        
        return false
    }
}

let stringWithNumber = "My phone number is 123-456-789"
let stringWithOutNumber = "My phone number doesn't exists"

stringWithNumber.containsNumeric()
stringWithOutNumber.containsNumeric()
