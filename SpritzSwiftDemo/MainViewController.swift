//
//  ViewController.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 02/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit
import SnapKit
import SpritzSwift


class MainViewController: UIViewController {
    
    var mainView = MainView()

    private var manager = SpritzSwiftManager(withText: "Welcome to SpritzSwift! Spritz is a brand new revolutionary reading method that will help you to improve your number of words per minute. Take a look at SpritzSwift!", andWordPerMinute: 250)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mainView
        
        mainView.playButton.addTarget(self, action: #selector(toggleSpritz) , for: UIControlEvents.touchUpInside)
        mainView.resumeButton.addTarget(self, action: #selector(resumeSpritz), for: UIControlEvents.touchUpInside)
        mainView.pauseButton.addTarget(self, action: #selector(pauseSpritz), for: UIControlEvents.touchUpInside)
    }

    @objc
    func pauseSpritz() {
        manager.pauseReading()
    }
    
    @objc
    func resumeSpritz() {
        manager.resumeReading()
    }
    
    @objc
    func toggleSpritz() {
        manager.startReading { (word, finished) in
            if !finished {
                self.mainView.ssView.updateWord(word!)
            }
        }
    }
}
