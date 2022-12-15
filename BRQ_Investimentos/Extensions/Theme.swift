//
//  Tema.swift
//  BRQ_Investimentos
//
//  Created by user on 19/10/22.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func viewBlue() -> UIColor {
        return UIColor.rgb(red: 5, green: 0, blue: 20)
    }
    
    static func viewOrange() -> UIColor {
        return UIColor.rgb(red: 20, green: 10, blue: 0)
    }
    
    static func variationGreen() -> UIColor {
        return UIColor.rgb(red: 126, green: 211, blue: 33)
    }
    
    static func variationRed() -> UIColor {
        return UIColor.rgb(red: 208, green: 2, blue: 27)
    }
    
    static func BRQGray() -> UIColor {
        return UIColor.rgb(red: 151, green: 151, blue: 151)
    }
    
    static func BRQGray2() -> UIColor {
        return UIColor.rgb(red: 34, green: 34, blue: 34)
    }
    
    static func BRQGray3() -> UIColor {
        return UIColor.rgb(red: 4, green: 4, blue: 4)
    }
    
    static func BRQBlue() -> UIColor {
        return UIColor.rgb(red: 60, green: 141, blue: 188)
    }
    
    static func BRQOrange() -> UIColor {
        return UIColor.rgb(red: 255, green: 139, blue: 26)
    }
    
}
