//
//  ViewCodeProtocol.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit
//TODO: avaliar a utilização do addictionalConfiguration para delegar a cor do tabbar e etc...
protocol ViewCodeProtocol: UIView {
    func buildViewHierachy()
    func setupConstraints()
    func addictionalConfiguration()
}

extension ViewCodeProtocol {
    func setupView() {
        buildViewHierachy()
        setupConstraints()
        addictionalConfiguration()
    }
}
