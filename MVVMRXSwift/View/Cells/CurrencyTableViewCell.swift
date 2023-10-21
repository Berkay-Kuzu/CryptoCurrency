//
//  CurrencyTableViewCell.swift
//  MVVMRXSwift
//
//  Created by Berkay Kuzu on 19.10.2023.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CurrencyTableViewCell.self)
    
    let currencyTitleLabel = UILabel()
    let currencySubtitleLabel = UILabel()
    
    var item: Crypto! {
        didSet {
            currencyTitleLabel.text = item.currency
            currencySubtitleLabel.text = item.price
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }
    
    private func setupContentView() {
        
        currencyTitleLabel.font = .systemFont(ofSize: 10, weight: .bold)
        currencyTitleLabel.textAlignment = .left
        currencyTitleLabel.textColor = .black
        contentView.addSubview(currencyTitleLabel)
        currencyTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
        }
        
       
        currencySubtitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        currencySubtitleLabel.textAlignment = .left
        currencySubtitleLabel.textColor = .black
        contentView.addSubview(currencySubtitleLabel)
        currencySubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(currencyTitleLabel.snp.bottom).offset(2)
            make.left.equalTo(currencyTitleLabel.snp.left)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
