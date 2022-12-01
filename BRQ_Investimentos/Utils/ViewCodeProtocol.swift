//
//  ViewCodeProtocol.swift
//  BRQ_Investimentos
//
//  Created by user on 18/10/22.
//

import UIKit

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
