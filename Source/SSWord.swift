//
//  SSWords.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 04/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation

class SSWord: NSObject {
    private static let minimum = 0.18
    private static let maximum = 0.3
    private static let minTreshold = 4.0
    private static let maxTreshold = 10.0
    
    var word: String = ""
    private var delay: TimeInterval = 0
    var markerPosition: Int = 0 //should be set private
    
    init(withWord word: String) {
        super.init()
        self.word = word
        self.delay = self.calculateDelay()
        self.markerPosition = self.getReaderMarkerPosition()
    }
    
    private func calculateDelay() -> TimeInterval {
        let length = Double(self.word.count)
        
        if (length < SSWord.minTreshold) {
            return SSWord.minimum
        }
        if (length > SSWord.maxTreshold) {
            return SSWord.maximum
        }
        
        return SSWord.minimum + ((SSWord.maximum - SSWord.minimum)/(SSWord.maxTreshold - SSWord.minTreshold))
    }
    
    func getReaderMarkerPosition() -> Int {
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
