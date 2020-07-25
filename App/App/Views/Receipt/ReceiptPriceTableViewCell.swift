//
//  ReceiptPriceTableViewCell.swift
//  App
//
//  Created by Sheikh Ahmed on 24/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class ReceiptPriceTableViewCell: UITableViewCell,NibBased {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var insurancePriceLabel: UILabel!
    @IBOutlet weak var insuranceTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        formatBasicView()
    }
    private func formatBasicView(){
        insurancePriceLabel.attributedText = nil
        insuranceTextLabel.attributedText = nil
    }
    func setupCell(cellData: (NSAttributedString?, NSAttributedString?)){
        formatinsuranceTextLabel(text: cellData.0)
        formatinsurancePriceLabel(price: cellData.1)
    }
    func formatinsurancePriceLabel(price: NSAttributedString?){
        insurancePriceLabel.attributedText = price
    }
    func formatinsuranceTextLabel(text: NSAttributedString?){
        insuranceTextLabel.attributedText = text
    }
}
