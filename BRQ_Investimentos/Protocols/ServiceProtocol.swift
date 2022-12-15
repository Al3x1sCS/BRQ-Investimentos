//
//  ServiceProtocol.swift
//  BRQ_Investimentos
//
//  Created by user on 24/10/22.
//

import Foundation

protocol GenericService: AnyObject{
    typealias completion <T> = (_ result: T,_ failure: Any?) -> Void
}

protocol ExchangeServiceDelegate: GenericService{
    func getData(completion: @escaping completion<Welcome?>)
}

enum Error: Swift.Error {
    
    case fileNotFound(name: String)
    case fileDecondingFailed(name:String, Swift.Error)
}
