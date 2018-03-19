//
//  ViewController.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 02/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    private var ssView: SSView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ssView = SSView(frame: CGRect(x: 20, y: 20, width: 200, height: 40 ))
        ssView!.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: 100)
        ssView!.defaultWord = SSWord(withWord: "Spritz")
        
        self.view.addSubview(ssView!)
        self.view.backgroundColor = UIColor.clear
        let blurBar = UIToolbar(frame: self.view.frame)
        blurBar.barStyle = UIBarStyle.default
        self.view.addSubview(blurBar)
        self.view.sendSubview(toBack: blurBar)
        
        playButton.addTarget(self, action: #selector(toggleSpritz) , for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func toggleSpritz() {
        let manager = SSManager(withText: "hey nacho how are you, I hope very good", andWordPerMinute: 300)
        manager.updateLabel { (word, finished) in
            if !finished {
                self.ssView?.updateWord(word!)
            }
        }
    }
    
}

