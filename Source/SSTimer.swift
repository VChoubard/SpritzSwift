//
//  SSTimer.swift
//  SpritzSwift
//
//  Created by vincent Choubard on 27/03/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import Foundation

class SSTimer {
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
