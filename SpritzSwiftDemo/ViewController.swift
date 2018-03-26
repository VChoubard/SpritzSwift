//
//  ViewController.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 02/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let playButton = UIButton()
    let pauseButton = UIButton()
    let resumeButton = UIButton()
    
    private var ssView: SSView?
    private var manager = SSManager(withText: "Welcome to SpritzSwift! Spritz is a brand new revolutionary reading method that will help you to improve your number of words per minute. Take a look at SpritzSwift!", andWordPerMinute: 250)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ssView = SSView(frame: CGRect(x: 20, y: 20, width: 200, height: 40 ), delegate: self)
        ssView!.initWord = SSWord(withWord: "Spritz")
        ssView!.backgroundColor = .clear
        self.view.addSubview(ssView!)
        
        ssView?.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.left.equalTo(self.view.snp.left).inset(20)
            make.right.equalTo(self.view.snp.right).inset(20)
            make.center.equalTo(self.view)
        }
        
        playButton.backgroundColor = .white
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        self.view.addSubview(playButton)
        
        playButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(ssView!.snp.bottom).inset(-16)
            make.left.equalTo(ssView!.snp.left)
        }
        
        pauseButton.backgroundColor = .white
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(.black, for: .normal)
        self.view.addSubview(pauseButton)
        
        pauseButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(ssView!.snp.bottom).inset(-16)
            make.left.equalTo(playButton.snp.right).offset(10)
        }
        
        resumeButton.backgroundColor = .white
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.black, for: .normal)
        self.view.addSubview(resumeButton)
        
        resumeButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(ssView!.snp.bottom).inset(-16)
            make.left.equalTo(pauseButton.snp.right).offset(10)
        }
        
        self.view.backgroundColor = UIColor.gray
        
        playButton.addTarget(self, action: #selector(toggleSpritz) , for: UIControlEvents.touchUpInside)
        resumeButton.addTarget(self, action: #selector(resumeSpritz), for: UIControlEvents.touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseSpritz), for: UIControlEvents.touchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.ssView?.updateWord(word!)
            }
        }
    }
}

extension ViewController: SSViewPresentationDelegate {
    func getMarkerOffset() -> CGFloat {
        return ssView!.frame.size.width/3
    }
    func getMarkerLength() -> CGFloat {
        return 5
    }
    func getMarkerColor() -> UIColor {
        return .red
    }
    func getLinesColor() -> UIColor {
        return .black
    }
    func getTextColor() -> UIColor {
        return .black
    }
}

