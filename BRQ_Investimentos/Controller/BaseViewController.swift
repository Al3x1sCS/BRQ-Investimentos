//
//  BaseViewController.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    // MARK: setupNavigation
    func setupNavigation(with title: String) {
        navigationItem.title = title
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!]
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: preferredStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
    }
    
}


extension BaseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        
        let allowedCharacterSet = CharacterSet.init(charactersIn: "0123456789")
        let textCharacterSet = CharacterSet.init(charactersIn: textField.text! + string)
        if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
            return false
        }
        return true
    }
    
}
