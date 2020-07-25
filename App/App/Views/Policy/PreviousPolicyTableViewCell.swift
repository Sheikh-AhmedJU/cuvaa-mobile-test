//
//  PreviousPolicyTableViewCell.swift
//  App
//
//  Created by Sheikh Ahmed on 24/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class PreviousPolicyTableViewCell: UITableViewCell, NibBased {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        formatBasicView()
    }
    private func formatBasicView(){
        timeLabel.attributedText = nil
        dateLabel.attributedText = nil
    }
    func setupCell(cellData: PolicyEventVM){
        formatTimeLabel(time: cellData.policyDuration, isCancelled: cellData.isCancelled)
        formatDateLabel(date: cellData.policyUpdateDate)
        self.accessoryType = .disclosureIndicator
    }
    private func formatTimeLabel(time: String?, isCancelled: Bool){
        let titleText = isCancelled ? "Voided" : time
        let font = AppFonts.labelFont(labelType: .regularInTableCell).font
        let color = isCancelled ? UIColor.red : AppColors.textColor(labelType: .headerInTableCell).color
        timeLabel.attributedText = titleText?.getAttributedTitle(font: font, textColor: color)
    }
    private func formatDateLabel(date: String?){
        let font = AppFonts.labelFont(labelType: .headerInImageButton).font
        let color = AppColors.textColor(labelType: .headerInTableCell).color
        dateLabel.attributedText = date?.getAttributedTitle(font: font, textColor: color)
    }
}
