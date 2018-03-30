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
    
    var mainView = MainView(frame: CGRect(x: 20, y: 20, width: 200, height: 40 ))

    private var manager = SSManager(withText: "Welcome to SpritzSwift! Spritz is a brand new revolutionary reading method that will help you to improve your number of words per minute. Take a look at SpritzSwift!", andWordPerMinute: 250)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(frame: CGRect(x: 20, y: 20, width: 200, height: 40 ))
        
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

extension MainViewController: SSViewPresentationDelegate {
    func getMarkerOffset() -> CGFloat {
        return self.view.frame.size.width/2
    }
//    func getMarkerLength() -> CGFloat {
//        return 5
//    }
//    func getMarkerColor() -> UIColor {
//        return .red
//    }
//    func getLinesColor() -> UIColor {
//        return .black
//    }
//    func getTextColor() -> UIColor {
//        return .black
//    }
}

