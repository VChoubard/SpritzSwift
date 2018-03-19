//
//  SSManager.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 02/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation

class SSManager {
    
    typealias StatusBlock = (_ words: SSWord?, _ finished: Bool) -> ()
    
    enum Status {
        case stopped
        case reading
        case notStarted
        case finished
    }
    
    private var text: String
    private var words: [String]
    private var current: Int
    private var speed: Double
    private var timer: Timer?
    private var status = Status.notStarted
    
    init(withText text: String, andWordPerMinute wpm: Int = 0) {
        self.text = text
        var wpm = wpm
        
        
        if wpm == 0 {
            wpm = 250
        }
        self.speed = Double(wpm)/60.0
        self.speed = 1/speed
        
        words = text.components(separatedBy: .whitespacesAndNewlines).map { $0 + " " }
        current = 0
    }
    
    func updateLabel(completion: @escaping StatusBlock) {
        var words = packageOfWords()
        timer = Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true, block: { (timer) in
            if (self.current != words.count) {
                if (self.current > 0) {
                    var end = Double(clock()) + (self.speed * Double(CLOCKS_PER_SEC))
                        if self.containsFullStop(wordToAnalyze: words[self.current - 1].word) {
                            end = Double(clock()) + (self.speed * Double(CLOCKS_PER_SEC))
                            while Double(clock()) < end {
                            }
                        }
                }
                self.status = .reading
                completion(words[self.current], false)
                self.current += 1
            } else if self.current == words.count {
                completion(nil, true);
                timer.invalidate()
                self.status = .finished
            }
        })
    }
    
    private func containsFullStop(wordToAnalyze word: String) -> Bool {
        if word.contains(". ") {
            return true
        } else if word.contains("! ") {
            return true
        } else if word.contains(", ") {
            return true
        } else if word.contains("... ") {
            return true
        } else if word.contains("… ") {
            return true
        } else if word.contains("? ") {
            return true
        } else if word.contains(": ") {
            return true
        } else if word.contains("; ") {
            return true
        } else {
            return false
        }
    }
    
    private func packageOfWords() -> [SSWord]{
        var packageOfWords = [SSWord]()
        for word in words {
            packageOfWords.append(SSWord(withWord: word))
        }
    
        return packageOfWords
    }
}
