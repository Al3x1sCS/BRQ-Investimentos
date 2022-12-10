//
//  KeyboardManeger.swift
//  BRQ_Investimentos
//
//  Created by user on 10/12/22.
//

import Foundation
import UIKit

class KeyboardManager {
    var window: UIWindow?
    
    private var currentTextField: UITextField?

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        self.currentTextField = currentTextField

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = window?.convert(currentTextField.frame, from: currentTextField.superview)
        guard let textBoxY = convertedTextFieldFrame?.origin.y else { return }

        let newFrameY = (textBoxY - keyboardTopY / 2) * -1.3
        window?.frame.origin.y = newFrameY
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        window?.frame.origin.y = 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
