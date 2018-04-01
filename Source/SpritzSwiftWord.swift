//
//  SSWords.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 04/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation

public class SpritzSwiftWord {
    private static let minimum = 0.18
    private static let maximum = 0.3
    private static let minTreshold = 4.0
    private static let maxTreshold = 10.0
    private var delay: TimeInterval = 0
    private(set) var markerPosition: Int = 0 
    
    public var word: String = ""
    
    public convenience init(withWord word: String) {
        self.init()
        self.word = word
        self.delay = self.calculateDelay()
        self.markerPosition = self.getReaderMarkerPosition()
    }
    
    private func calculateDelay() -> TimeInterval {
        let length = Double(self.word.count)
        
        if (length < SpritzSwiftWord.minTreshold) {
            return SpritzSwiftWord.minimum
        }
        if (length > SpritzSwiftWord.maxTreshold) {
            return SpritzSwiftWord.maximum
        }
        
        return SpritzSwiftWord.minimum + ((SpritzSwiftWord.maximum - SpritzSwiftWord.minimum)/(SpritzSwiftWord.maxTreshold - SpritzSwiftWord.minTreshold))
    }
    
    private func getReaderMarkerPosition() -> Int {
        let length = self.word.count
        var letter = 0
        switch (length) {
        case 1, 2:
            letter = 0
        case 3, 4, 5:
            letter = 1
        case 6, 7, 8, 9:
            letter = 2
        case 10, 11, 12, 13:
            letter = 3
        default:
            letter = 4
        }
        
        return letter
    }
}
