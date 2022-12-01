//
//  LabelDefault.swift
//  BRQ_Investimentos
//
//  Created by user on 25/11/22.
//

import Foundation
import UIKit

class LabelDefault: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        
        initDefault(text: text, font: UIFont(name: "Arial", size: 16.0) ?? UIFont.systemFont(ofSize: 16), alignment: .left)
    }
    
    init(text: String, font: UIFont) {
        super.init(frame: .zero)
        
        initDefault(text: text, font: font,  alignment: .left)
    }
    
    init(text: String, font: UIFont, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        initDefault(text: text, font: font, alignment: alignment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initDefault(text: String, font: UIFont, alignment: NSTextAlignment) {
        self.backgroundColor = .black
        self.text = text
        self.font = font
        self.textColor = .white
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
    }
    
}
