//
//  HGFinanceService.swift
//  BRQ_Investimentos
//
//  Created by user on 22/10/22.
//

import Foundation
import Alamofire

class HGFinanceService: ExchangeServiceDelegate {
    func getData(completion: @escaping completion<Welcome?>) {
        let baseUrl = "https://api.hgbrasil.com/finance?key=a6cb5965"
        
        AF.request(baseUrl, method: .get).validate().responseDecodable(of: Welcome.self) { response in
            debugPrint(response)
            
            guard let data = response.data else { return }
            debugPrint(data)
            
            switch response.result{
            case .success(let success):
                print("SUCCESS -> \(#function)")
                completion(success, nil)
            case .failure(_):
                print("ERROR -> \(#function)")
                //TODO: bela tratativa de erro parabains, devo estudar mais sobre tratar erros de api
                completion(nil, nil)
                
            }
        }
    }
}
