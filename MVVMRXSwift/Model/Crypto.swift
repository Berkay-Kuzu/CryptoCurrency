//
//  Crypto.swift
//  MVVMRXSwift
//
//  Created by Berkay Kuzu on 19.10.2023.
//

import Foundation

class Crypto: Codable {
    
    internal init(currency: String? = nil, price: String? = nil) {
        self.currency = currency
        self.price = price
    }
    
    let currency: String?
    let price: String?
}
