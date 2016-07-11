//
//  UIColor+App.swift
//  MyMovieApp
//
//  Created by Nhung Huynh on 7/11/16.
//  Copyright © 2016 Nhung Huynh. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func appTintColor() -> UIColor {
        return UIColor(red: 50/255.0, green: 167/255.0, blue: 255/255.0, alpha: 1.0)
    }
    
    class func appMessageColor() -> UIColor {
        return UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0)
    }
    
    
    class func appNavgationBarTitleColor() -> UIColor {
        return UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1.0)
    }
    
    class func appViewBackgroundColor() -> UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
    }
    
    class func appInputTextColor() -> UIColor {
        return UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1.0)
    }
    
    class func appMessageToolbarSubviewBorderColor() -> UIColor {
        return UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    }
    
    class func appBorderColor() -> UIColor {
        return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    class func avatarBackgroundColor() -> UIColor {
        return UIColor(red: 50/255.0, green: 167/255.0, blue: 255/255.0, alpha: 0.3)
    }
    
    class func leftBubbleTintColor() -> UIColor {
        return UIColor(white: 231 / 255.0, alpha: 1.0)
    }
    
    class func rightBubbleTintColor() -> UIColor {
        return UIColor.appTintColor()
    }
    
    class func leftWaveColor() -> UIColor {
        return UIColor.darkGrayColor().colorWithAlphaComponent(0.2)
    }
    
    class func rightWaveColor() -> UIColor {
        return UIColor(red:0.176,  green:0.537,  blue:0.878, alpha:1)
    }
    
    class func skillMasterColor() -> UIColor {
        return appTintColor()
    }
    
    class func skillLearningColor() -> UIColor {
        return UIColor(red:0.49, green:0.83, blue:0.13, alpha:1)
    }
    
    class func messageToolBarColor() -> UIColor {
        return UIColor(red:0.557, green:0.557, blue:0.576, alpha:1)
    }
    
    class func messageToolBarHighlightColor() -> UIColor {
        return UIColor.appTintColor()
    }
    
    class func messageToolBarNormalColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    class func appDisabledColor() -> UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
    }
    
    class func appGrayColor() -> UIColor {
        return UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    }
    
    class func appBackgroundColor() -> UIColor {
        return UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
    }
    
    class func appCellSeparatorColor() -> UIColor {
        return UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
    }
    
    class func appCellAccessoryImageViewTintColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    class func appIconImageViewTintColor() -> UIColor {
        return appCellAccessoryImageViewTintColor()
    }
}

extension UIColor {
    
    class func app_mangmorGrayColor() -> UIColor {
        return UIColor(red: 199/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1)
    }
}

extension UIColor {
    
    var app_inverseColor: UIColor {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha)
    }
    
    var app_binaryColor: UIColor {
        
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        
        return white > 0.92 ? UIColor.blackColor() : UIColor.whiteColor()
    }
    
    var app_profilePrettyColor: UIColor {
        return app_binaryColor
    }
}

