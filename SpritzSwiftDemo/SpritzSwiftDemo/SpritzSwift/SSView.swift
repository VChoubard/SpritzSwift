//
//  SSView.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 18/03/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit

class SSView: UIView {
    
    private var ssLabel: SSLabel?
    var markerOffset: CGFloat = 0.0
    var markerLength: CGFloat = 5.0
    var markerColor: UIColor = UIColor.red
    var markingLinesColor: UIColor = UIColor.black
    
    var defaultWord = SSWord(withWord: "Spritz")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initParam()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initParam()
    }
    
    func updateWord(_ word: SSWord) {
        ssLabel!.word = word
        ssLabel!.setNeedsDisplay()
    }
    
    private func initParam() {
        self.backgroundColor = .clear
        markerOffset = self.frame.size.width/3
        ssLabel = SSLabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        ssLabel!.word = defaultWord
        self.addSubview(ssLabel!)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let verticalOffset: CGFloat = 4.0
        let horizontalOffset: CGFloat = 10.0
        
        self.markingLinesColor.set()
        self.drawLineInContextWithWidth(1.0, fromPointX: markerOffset, fromPointY: self.frame.size.height-markerLength - verticalOffset, toPointX: markerOffset, toPointY: self.frame.size.height - verticalOffset)
        self.drawLineInContextWithWidth(1.0, fromPointX: markerOffset, fromPointY: verticalOffset, toPointX: markerOffset, toPointY: markerLength + verticalOffset)
        
        self.drawLineInContextWithWidth(2.0, fromPointX: horizontalOffset, fromPointY: verticalOffset, toPointX: self.frame.size.width - horizontalOffset, toPointY: verticalOffset)
        self.drawLineInContextWithWidth(2.0, fromPointX: horizontalOffset, fromPointY: self.frame.size.height-verticalOffset ,toPointX: self.frame.size.width - horizontalOffset, toPointY: self.frame.size.height-verticalOffset)
    }
    
    private func drawLineInContextWithWidth(_ width: CGFloat, fromPointX fx: CGFloat, fromPointY fy: CGFloat, toPointX tx: CGFloat, toPointY ty: CGFloat) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(width)
        context?.move(to: CGPoint(x: fx, y: fy))
        context?.addLine(to: CGPoint(x: tx, y: ty))
        context?.strokePath()
    }
}
