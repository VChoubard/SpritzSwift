//
//  SSLabel.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 04/02/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit
import CoreText

class SpritzSwiftLabel: UIView {
    
    var markerColor: UIColor = UIColor.red
    var textColor: UIColor = UIColor.black
    var textFont: UIFont = UIFont.systemFont(ofSize: 20)
    var markerOffset: CGFloat = UIScreen.main.bounds.width/3

    private var headerWidth: CGFloat = 0
    private var tailWidth: CGFloat = 0
    private var markerWidth: CGFloat = 0
    private var textVerticalPosition: CGFloat = 15
    private var textHorizontalPosition: CGFloat = 0
    
    var word = Word(withWord: " ")
    
    override func layoutSubviews() {
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        self.flipCoordinateSystemForCoreText()
        
        let path = CGMutablePath()
        path.addRect(self.bounds)
        
        //create the attstring
        let attString = NSMutableAttributedString(string: word.word)
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: markerColor , range:NSMakeRange(self.word.markerPosition, 1))
        attString.addAttribute(NSAttributedStringKey.font, value: self.textFont, range: NSMakeRange(0, self.word.word.count))

    
        // create the frame
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        let frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, attString.length), path, nil)
        let lines = CTFrameGetLines(frame)
        
        //check the size of each glyph to put the marker at a fix position
        for index in 0..<CFArrayGetCount(lines) {
            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, index), to: CTLine.self)
            let glyphRuns = CTLineGetGlyphRuns(line)
            for runIndex in 0..<CFArrayGetCount(glyphRuns) {
                let run = unsafeBitCast(CFArrayGetValueAtIndex(glyphRuns, runIndex), to: CTRun.self)
                var width: CGFloat = 0.0
                width = CGFloat(CTRunGetTypographicBounds(run, CFRangeMake(0, 0), nil, nil, nil))
                switch(runIndex) {
                case 0:
                    headerWidth = width
                    if CFArrayGetCount(glyphRuns) == 1 {
                        headerWidth = 0
                        markerWidth = width
                        self.recomputeTextHorizontalPosition()
                    }
                case 1:
                    markerWidth = width
                    if CFArrayGetCount(glyphRuns) == 2 {
                        if (self.word.markerPosition != 0) {
                            
                        } else {
                            markerWidth = headerWidth
                            headerWidth = 0
                            markerWidth = width
                        }
                        self.recomputeTextHorizontalPosition()
                    }
                case 2:
                    tailWidth = width
                    self.recomputeTextHorizontalPosition()
                default:
                    break
                }
            }
            
            let runsCount = CFArrayGetCount(glyphRuns)
            for runIndex in 0..<runsCount {
                let run = unsafeBitCast(CFArrayGetValueAtIndex(glyphRuns, runIndex), to: CTRun.self)
                
                let runFont = unsafeBitCast(CFDictionaryGetValue(CTRunGetAttributes(run), Unmanaged.passUnretained((kCTFontAttributeName)).toOpaque()), to: CTFont.self)
                
                for runGlyphIndex in 0..<CTRunGetGlyphCount(run) {
                    let thisGlyphRange = CFRangeMake(runGlyphIndex, 1)
                    var glyph = CGGlyph()
                    var position = CGPoint.zero
                    CTRunGetGlyphs(run, thisGlyphRange, &glyph)
                    CTRunGetPositions(run, thisGlyphRange, &position)
                    if (runsCount >= 3 && runIndex == 1) ||
                        (runsCount == 1 && self.word.markerPosition == 0) ||
                        (runsCount == 2 && self.word.markerPosition != 0 && runIndex > 0) ||
                        (runsCount == 2 && self.word.markerPosition == 0 && runIndex == 0) {
                        context!.setFillColor(self.markerColor.cgColor)
                    } else {
                        context!.setFillColor(self.textColor.cgColor)
                    }
                    
                    position = CGPoint(x: position.x + textHorizontalPosition,y: position.y + textVerticalPosition)
                    let textMatrix = CTRunGetTextMatrix(run)
                    let cgFont = CTFontCopyGraphicsFont(runFont, nil)
                    
                    context!.textMatrix = textMatrix
                    context!.setFont(cgFont)
                    context!.setFontSize(CTFontGetSize(runFont))
                    context!.showGlyphs([glyph], at: [position])
                    
                }
            }
        }
    }
    
    private func flipCoordinateSystemForCoreText() {
        let context = UIGraphicsGetCurrentContext()
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: self.bounds.size.height)
        context!.scaleBy(x: 1, y: -1)
    }
    
    private func recomputeTextHorizontalPosition() {
        let markerOffset = self.markerOffset
        textHorizontalPosition = markerOffset - (headerWidth + markerWidth/2.0)
    }
}


