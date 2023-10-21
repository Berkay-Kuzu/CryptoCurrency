//
//  CryptoViewModel.swift
//  MVVMRXSwift
//
//  Created by Berkay Kuzu on 19.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    //Publish these objects in ViewModel and subscribe them in ViewController.
    
     func requestData() {
        self.loading.onNext(true)
        APIManager.downloadCryptos { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
                print(error.localizedDescription)
            }
        }
    }
}
