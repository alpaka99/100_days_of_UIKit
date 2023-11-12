import Foundation


public enum VisibleStatus {
    case visible
    case hidden
}

public enum TextType {
    case inComming
    case outGoing
}

// short
public var shortMessages: [[ChatMessage]] = [
    [
        ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25"),
        ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
    ]
]

// middle
public let middleMessages: [[ChatMessage]] = [
    [
        ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25"),
        ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
    ],
    [
        ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
        ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/26"),
        ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26")
    ],
    [
        ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
        ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27"),
        ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
        ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27")
    ],
    [
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/28"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
    ],
]

// long
public let longMessages: [[ChatMessage]] = [
    [
        ChatMessage(text: "Here is my first message", textType: .inComming, date: "23/05/25"),
        ChatMessage(text: "I'm going to message another long message that will word wrap", textType: .inComming, date: "23/05/25")
    ],
    [
        ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
        ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26"),
        ChatMessage(text: "I'm going to message another long message that will word wrap I'm going to message another long message that will word wrap", textType: .outGoing, date: "23/05/26")
    ],
    [
        ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
        ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27"),
        ChatMessage(text: "I'm going to message another long message that will word wrap ", textType: .inComming, date: "23/05/27"),
        ChatMessage(text: "whaddup dawg", textType: .outGoing, date: "23/05/27")
    ],
    [
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/28"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/28"),
    ],
    [
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/29"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/29"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/29"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/29"),
    ],
    [
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/30"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/30"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/30"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/30"),
    ],
    [
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .inComming, date: "23/05/31"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31"),
        ChatMessage(text: ".", textType: .inComming, date: ""),
        ChatMessage(text: ".", textType: .outGoing, date: ""),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31"),
        ChatMessage(text: "Fourth ChatMessage on the way", textType: .outGoing, date: "23/05/31")
    ]
]
