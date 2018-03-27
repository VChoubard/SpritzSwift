//
//  SSManager.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 02/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation

public class SSManager {
    
    private class SSTimer {
        let timer: Timer
        var pauseDate: Date?
        var previousFireDate: Date?
        var isValid: Bool = true
        
        init(timer: Timer) {
            self.timer = timer
            self.isValid = timer.isValid
        }
        
        func invalidate() {
            self.timer.invalidate()
        }
        
        func pause() {
            pauseDate = Date()
            previousFireDate = self.timer.fireDate
            self.timer.fireDate = Date.distantFuture
        }
        
        func resume() {
            if let pauseDate = pauseDate, let previousFireDate = previousFireDate {
                let pauseTime = -pauseDate.timeIntervalSinceNow
                self.timer.fireDate = Date(timeInterval: pauseTime, since: previousFireDate)
            }
        }
    }
    
    public typealias StatusBlock = (_ words: SSWord?, _ finished: Bool) -> ()
    
    public enum Status {
        case stopped
        case reading
        case notStarted
        case finished
    }
    
    private var text: String
    private var words = [SSWord]()
    private var current: Int = 0
    private var speed: Double
    private var timer: SSTimer?
    private(set) var status = Status.notStarted
    
    public init(withText text: String, andWordPerMinute wpm: Int?) {
        self.text = text
        self.speed = Double(wpm ?? 250)/60.0
        self.speed = 1/speed
        
        words = self.package(ofWords: text.components(separatedBy: .whitespacesAndNewlines).map { $0 + " " })
    }
    
    public func startReading(completion: @escaping StatusBlock) {
        current = 0

        guard let timer = timer, timer.isValid, status != .stopped else {
            self.timer?.invalidate()
            self.timer = SSTimer(timer: Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true, block: { (timer) in
                if (self.current != self.words.count) {
                    if (self.current > 0) {
                        var end = Double(clock()) + (self.speed * Double(CLOCKS_PER_SEC))
                        if self.containsFullStop(wordToAnalyze: self.words[self.current - 1].word) {
                            end = Double(clock()) + (self.speed * Double(CLOCKS_PER_SEC))
                            while Double(clock()) < end {
                            }
                        }
                    }
                    self.status = .reading
                    completion(self.words[self.current], false)
                    self.current += 1
                } else if self.current == self.words.count {
                    completion(nil, true);
                    timer.invalidate()
                    self.status = .finished
                }
            }))
            return
        }
    }
    
    public func resumeReading() {
        if status == .stopped {
            status = .reading
            timer?.resume()
        } else {
            print("SpritzSwift message: Reading can only be resumed when is stopped")
        }
    }

    public func pauseReading() {
        if status == .reading {
            status = .stopped
            timer?.pause()
        } else {
            print("SpritzSwift message: Reading can only be paused when the reading is active")
        }
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
    
    private func package(ofWords words: [String]) -> [SSWord]{
        var packageOfWords = [SSWord]()
        for word in words {
            packageOfWords.append(SSWord(withWord: word))
        }
    
        return packageOfWords
    }
}
