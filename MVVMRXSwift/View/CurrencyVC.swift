//
//  ViewController.swift
//  MVVMRXSwift
//
//  Created by Berkay Kuzu on 19.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyVC: UIViewController {
    
    lazy var currencyTableView = UITableView(frame: .zero, style: .insetGrouped)
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    var cryptoList: [Crypto] = []
    let cryptoViewModel = CryptoViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        cryptoViewModel.requestData()
        
    }

    private func setupUI() {
      
        currencyTableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
//        currencyTableView.delegate = self
//        currencyTableView.dataSource = self
        currencyTableView.rx.setDelegate(self).disposed(by: disposeBag)
        view.addSubview(currencyTableView)
        currencyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
        /*
        cryptoViewModel
            .loading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { loading in
                if loading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
        */
        
        cryptoViewModel
            .loading
            .bind(to: self.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        cryptoViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        cryptoViewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: currencyTableView.rx.items(cellIdentifier: CurrencyTableViewCell.identifier, cellType: CurrencyTableViewCell.self)) {row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
        
        
        /*
        cryptoViewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.currencyTableView.reloadData()
        }
            .disposed(by: disposeBag)
         */
    }
}

extension CurrencyVC: UITableViewDelegate {
    
    /*
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        let crypto = cryptoList[indexPath.row]
        cell.currencyTitleLabel.text = crypto.currency
        cell.currencySubtitleLabel.text = crypto.price
        return cell
    }
    */
    
}
