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

    private var spritzSwiftViewController: SpritzSwiftViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spritzSwiftViewController = SpritzSwiftRouter.setupModule()
        spritzSwiftViewController?.setup(withText: "Welcome to SpritzSwift! Spritz is a brand new revolutionary reading method that will help you to improve your number of words per minute. Take a look at SpritzSwift!", wordPerMinute: 250)
        
        mainView.ssView = spritzSwiftViewController!.view
        self.view = mainView
        
        mainView.playButton.addTarget(self, action: #selector(toggleSpritz) , for: UIControlEvents.touchUpInside)
        mainView.resumeButton.addTarget(self, action: #selector(resumeSpritz), for: UIControlEvents.touchUpInside)
        mainView.pauseButton.addTarget(self, action: #selector(pauseSpritz), for: UIControlEvents.touchUpInside)
    }

    @objc
    func pauseSpritz() {
        spritzSwiftViewController?.tapOnPause()
    }
    
    @objc
    func resumeSpritz() {
        spritzSwiftViewController?.tapOnPlay()
    }
    
    @objc
    func toggleSpritz() {
        spritzSwiftViewController?.tapOnPlay()
    }
}
