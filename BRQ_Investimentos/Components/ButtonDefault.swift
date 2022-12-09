//
//  ButtonDefault.swift
//  BRQ_Investimentos
//
//  Created by user on 28/11/22.
//

import Foundation
import UIKit
//TODO: tem varias coisas espalhadas, juntar tudo que for responsabilidade do initDefault e analisar a posibilidade de adicionar mais parametros no inits ou ate mesmo criar mais inits para mais tipos de botões
class ButtonDefault: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        initDefault(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initDefault(title: String) {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .BRQBlue()
        config.cornerStyle = .capsule
        self.configuration = config
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 21.5
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 23) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
        ])
        
        self.setAttributedTitle(attributedText, for: .normal)
        self.setBackgroundColor(UIColor.BRQBlue().withAlphaComponent(0.5), for: .disabled)
    }
    
    enum ButtonState {
        case normal
        case disabled
    }
    
    private var disabledBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
            }
            else {
                if let color = disabledBackgroundColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .disabled:
            disabledBackgroundColor = color
            
        case .normal:
            defaultBackgroundColor = color
        }
    }
}
