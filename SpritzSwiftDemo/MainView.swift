//
//  MainView.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 29/03/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit
import SnapKit
import SpritzSwift

class MainView: UIView {
    
    var ssView: SSView
    let playButton = UIButton()
    let pauseButton = UIButton()
    let resumeButton = UIButton()
    
    override init(frame: CGRect) {
        ssView = SSView(frame: frame)
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        ssView = SSView(frame: CGRect.zero)
        super.init(coder: aDecoder)
        layout()
    }
    
    func layout() {
        ssView.initWord = SSWord(withWord: "Spritz")
        ssView.backgroundColor = .clear
        self.addSubview(ssView)
        
        ssView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.left.equalTo(self.snp.left).inset(20)
            make.right.equalTo(self.snp.right).inset(20)
            make.center.equalTo(self)
        }
        
        playButton.backgroundColor = .white
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        self.addSubview(playButton)
        
        playButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(ssView.snp.bottom).inset(-16)
            make.left.equalTo(ssView.snp.left)
        }
        
        pauseButton.backgroundColor = .white
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(.black, for: .normal)
        self.addSubview(pauseButton)
        
        pauseButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(ssView.snp.bottom).inset(-16)
            make.left.equalTo(playButton.snp.right).offset(10)
        }
        
        resumeButton.backgroundColor = .white
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.black, for: .normal)
        self.addSubview(resumeButton)
        
        resumeButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(ssView.snp.bottom).inset(-16)
            make.left.equalTo(pauseButton.snp.right).offset(10)
        }
        
        self.backgroundColor = UIColor.gray
    }
    
}
