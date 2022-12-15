//
//  StaticFuncUtils.swift
//  BRQ_Investimentos
//
//  Created by user on 14/12/22.
//

import Foundation

class Utils {
    /// Formata um double para uma string em formato de moeda brasileira
    ///
    /// - Parameters:
    ///   - number: O número a ser formatado em formato de moeda brasileira.
    ///
    /// - Returns: Retorna a string com o número em formato de moeda brasileira.
    static func coinFormatter(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        return formatter.string(from: NSNumber(value: number)) ?? "0.00"
    }
}


