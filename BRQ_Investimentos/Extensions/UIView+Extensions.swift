//
//  Extensions.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit
//TODO: avaliar a possibilidade de fazer mais incrementações
extension UIView {
    
    /// Centraliza a visualização atual em uma visualização especificada.
    /// - Parameter view: A visualização na qual a visualização atual deve ser centralizada.
    func center(inView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    /// Ancora a visualização atual em relação a outras visualizações,
    /// Os parametros "top", "left", "bottom", "right", aceitam valores nulos (nil)
    /// Os parametros "paddingTop", "paddingLeft", "paddingBottom", "paddingRight", "width", "height",
    /// não aceitam valores nulos mas adicionando um valor = 0 o comportamente é similar
    /// ao uso de valores nulos (nil)
    /// - Parameters:
    ///   - top: O ancorador de eixo Y (opcional) no qual o ancorador de topo da visualização atual deve estar alinhado.
    ///   - left: O ancorador de eixo X (opcional) no qual o ancorador esquerdo da visualização atual deve estar alinhado.
    ///   - bottom: O ancorador de eixo Y (opcional) no qual o ancorador inferior da visualização atual deve estar alinhado.
    ///   - right: O ancorador de eixo X (opcional) no qual o ancorador direito da visualização atual deve estar alinhado.
    ///   - paddingTop: O espaçamento no topo da visualização atual.
    ///   - paddingLeft: O espaçamento à esquerda da visualização atual.
    ///   - paddingBottom: O espaçamento no fundo da visualização atual.
    ///   - paddingRight: O espaçamento à direita da visualização atual.
    ///   - width: A largura da visualização atual.
    ///   - height: A altura da visualização atual.
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

//    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
//        }
//
//        if let left = left {
//            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
//        }
//
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
//        }
//
//        if let right = right {
//            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
//        }
//
//        if width != 0 {
//            widthAnchor.constraint(equalToConstant: width).isActive = true
//        }
//
//        if height != 0 {
//            heightAnchor.constraint(equalToConstant: height).isActive = true
//        }
//    }
}



extension UIView {
    func constraintsBuild (
        inView view: UIView,
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat = 0,
        height: CGFloat = 0,
        widthMultiplier: CGFloat = 0,
        heightMultiplier: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        } else if widthMultiplier != 0 {
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier, constant: 0).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        } else if heightMultiplier != 0 {
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightMultiplier, constant: 0).isActive = true
        }
        if width != 0 || widthMultiplier != 0 {
            widthAnchor.constraint(equalTo: widthAnchor, constant: 0).priority = priority
        }
        if height != 0 || heightMultiplier != 0 {
            heightAnchor.constraint(equalTo: heightAnchor, constant: 0).priority = priority
        }
    }
}
