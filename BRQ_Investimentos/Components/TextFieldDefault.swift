//
//  TextFieldDefault.swift
//  BRQ_Investimentos
//
//  Created by user on 28/11/22.
//

import Foundation
import UIKit


class TextFieldDefault: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        
        initDefault(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initDefault(placeholder: String) {
        self.backgroundColor = .black
        self.textColor = .white
        self.placeholder = placeholder
        self.keyboardType = .numberPad
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.temaGray().cgColor
        self.setPlaceHolderColor()
        self.setLeftPaddingPoints(10)
    }
}
