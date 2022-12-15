//
//  Utils.swift
//  BRQ_Investimentos
//
//  Created by user on 14/12/22.
//

import Foundation

class Utils {
    static func coinFormatter(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        return formatter.string(from: NSNumber(value: number)) ?? "0.00"
    }
}
