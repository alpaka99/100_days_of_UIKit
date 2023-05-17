//
//  ViewController.swift
//  UIKit_day_41
//
//  Created by user on 2023/05/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    
    
    var words = [String]()
    var usedLetter = [String]()
    var answerWord = ""
    var promptWord = ""
    var textViews = [UITextView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // initial loading all words
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.loadWords()
            self?.setNewWord()
        }
        
        
        
        // initially set navigation title
        
    }

    func loadWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                words = startWords.components(separatedBy: "\n")
            }
        } else {
            words = ["silkworm"]
        }
    }
    
    func setNewWord() {
        words.shuffle()
        answerWord = words[0]
        promptWord = ""
        for _ in answerWord {
            promptWord += "?"
        }
        DispatchQueue.main.async { [weak self] in
            self?.title = self?.answerWord
            self?.textView.text = self?.promptWord
        }
    }
    
    func checkLetter(letter: Character) {
        
    }

}

