//
//  SSView.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 18/03/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit

public class SpritzSwiftView: UIView {
    
    private var ssLabel = SpritzSwiftLabel()
    private var markerLength: CGFloat = 5.0
    
    public var markerOffset = UIScreen.main.bounds.width/3
    public var markerColor = UIColor.red
    public var markingLinesColor = UIColor.black
    public var textColor = UIColor.black
    public var textFont = UIFont.systemFont(ofSize: 20)
    
    public var initWord = SpritzSwiftWord(withWord: "Spritz")
    
    public func updateWord(_ word: SpritzSwiftWord) {
        ssLabel.word = word
        ssLabel.setNeedsDisplay()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let verticalOffset: CGFloat = 4.0
        let horizontalOffset: CGFloat = 10.0
        
        let markerOffset = self.markerOffset
        let markerLength = self.markerLength
        
        self.markingLinesColor.set()
        self.drawLineInContextWithWidth(1.0, fromPointX: markerOffset, fromPointY: self.frame.size.height-markerLength - verticalOffset, toPointX: markerOffset, toPointY: self.frame.size.height - verticalOffset)
        self.drawLineInContextWithWidth(1.0, fromPointX: markerOffset, fromPointY: verticalOffset, toPointX: markerOffset, toPointY: markerLength + verticalOffset)
        
        self.drawLineInContextWithWidth(2.0, fromPointX: horizontalOffset, fromPointY: verticalOffset, toPointX: self.frame.size.width - horizontalOffset, toPointY: verticalOffset)
        self.drawLineInContextWithWidth(2.0, fromPointX: horizontalOffset, fromPointY: self.frame.size.height-verticalOffset ,toPointX: self.frame.size.width - horizontalOffset, toPointY: self.frame.size.height-verticalOffset)
    }
    
    override public func layoutSubviews() {
        markerOffset = markerOffset == 0 ? self.bounds.width/2 : markerOffset
        ssLabel.markerOffset = markerOffset
        ssLabel.markerColor = markerColor
        ssLabel.textFont = textFont
        ssLabel.textColor = textColor
        
        ssLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: ssLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: ssLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: ssLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: ssLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        ssLabel.word = initWord
        ssLabel.backgroundColor = .red
        self.addSubview(ssLabel)
        addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        layoutIfNeeded()
    }
    
    private func drawLineInContextWithWidth(_ width: CGFloat, fromPointX fx: CGFloat, fromPointY fy: CGFloat, toPointX tx: CGFloat, toPointY ty: CGFloat) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(width)
        context?.move(to: CGPoint(x: fx, y: fy))
        context?.addLine(to: CGPoint(x: tx, y: ty))
        context?.strokePath()
    }
}
