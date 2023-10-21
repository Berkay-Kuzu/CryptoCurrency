//
//  APIManager.swift
//  MVVMRXSwift
//
//  Created by Berkay Kuzu on 19.10.2023.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parsingError
}

class APIManager {
    
    static func downloadCryptos(completion: @escaping(Result<[Crypto], CryptoError>) -> Void) {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.serverError))
            } else if let data {
                do {
                    let results = try JSONDecoder().decode([Crypto].self, from: data)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                completion(.failure(.parsingError))
            }
        }
        task.resume()
    }
}
































//enum CryptoError: Error {
//    case serverError
//    case parsingError
//}
//
//class APIManager{
//    
//    static func downloadCurrencies( completion: @escaping (Result<[Crypto], CryptoError>) -> Void) {
//        
//        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {return}
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error {
//                completion(.failure(.serverError))
//            } else if let data {
//                do {
//                    let cryptoList = try JSONDecoder().decode([Crypto].self, from: data)
//                    completion(.success(cryptoList))
//                } catch {
//                    completion(.failure(.parsingError))
//                }
//               
//            }
//        }
//        task.resume()
//    }
//    
//}
