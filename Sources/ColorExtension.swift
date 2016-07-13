//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Tom Baranes. All rights reserved.
//

import Foundation
#if os(OSX)
    import Cocoa
#else
    import UIKit
#endif

// MARK: Init

public extension SwiftyColor {

    public convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }

    public convenience init(hex: String, alpha: Float) {
        let hex = hex.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

}

// MARK: - Components

public extension SwiftyColor {

    #if !os(OSX)
    
    public var redComponent: Int {
    var r: CGFloat = 0
    getRed(&r, green: nil, blue: nil, alpha: nil)
    return Int(r * 255)
    }

    public var greenComponent: Int {
    var g: CGFloat = 0
    getRed(nil, green: &g, blue: nil, alpha: nil)
    return Int(g * 255)
    }

    public var blueComponent: Int {
    var b: CGFloat = 0
    getRed(nil, green: nil, blue: &b, alpha: nil)
    return Int(b * 255)
    }

    public var alpha: CGFloat {
    var alpha: CGFloat = 0
    getRed(nil, green: nil, blue: nil, alpha: &alpha)
    return alpha
    }

    #endif

}

// MARK: Get Colors

public extension SwiftyColor {
    
    public func lighter(amount : CGFloat = 0.25) -> SwiftyColor {
        return hueColorWithBrightnessAmount(1 + amount)
    }
    
    public func darker(amount : CGFloat = 0.25) -> SwiftyColor {
        return hueColorWithBrightnessAmount(1 - amount)
    }
    
    private func hueColorWithBrightnessAmount(amount: CGFloat) -> SwiftyColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        #if os (iOS) || os (tvOS)
            if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
                return SwiftyColor(hue: hue,
                               saturation: saturation,
                               brightness: brightness * amount,
                               alpha: alpha)
            } else {
                return self
            }
        #else
            getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            return SwiftyColor(hue: hue,
                               saturation: saturation,
                               brightness: brightness * amount,
                               alpha: alpha)
        #endif
        
    }
    
}
