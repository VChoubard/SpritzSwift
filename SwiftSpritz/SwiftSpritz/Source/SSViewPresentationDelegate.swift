//
//  SSViewPresentationDelegate.swift
//  SpritzSwiftDemo
//
//  Created by vincent Choubard on 25/03/2018.
//  Copyright © 2018 Vincent Choubard. All rights reserved.
//

import UIKit

@objc
protocol SSViewPresentationDelegate {
    @objc optional func getMarkerOffset() -> CGFloat
    @objc optional func getMarkerLength() -> CGFloat
    @objc optional func getMarkerColor() -> UIColor
    @objc optional func getLinesColor() -> UIColor
    
    @objc optional func getTextColor() -> UIColor
    @objc optional func getTextFont() -> UIFont
}
