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
    
    static func variationGreen() -> UIColor {
        return UIColor.rgb(red: 126, green: 211, blue: 33)
    }
    
    static func variationRed() -> UIColor {
        return UIColor.rgb(red: 208, green: 2, blue: 27)
    }
    
    static func temaGray() -> UIColor {
        return UIColor.rgb(red: 151, green: 151, blue: 151)
    }
    
    static func buttons() -> UIColor {
        return UIColor.rgb(red: 60, green: 141, blue: 188)
    }
    
}
