//
//  TextFieldExtension.swift
//  BRQ_Investimentos
//
//  Created by user on 15/12/22.
//

import Foundation
import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPlaceHolderColor(_ color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
      textField.resignFirstResponder()
    }
    
}
