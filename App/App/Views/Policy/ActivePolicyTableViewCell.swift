//
//  ActivePolicyTableViewCell.swift
//  App
//
//  Created by Sheikh Ahmed on 23/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit
enum ActivePolicyButtonType{
    case policy
    case help
}
class ActivePolicyTableViewCell: UITableViewCell, NibBased {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var policyTypeView: UIView!
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBOutlet weak var remainingTimeView: UIView!
    @IBOutlet weak var graphicRemainingTimeView: UIView!
    @IBOutlet weak var textRemainingTimeView: UIView!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    @IBOutlet weak var policyHelpView: UIView!
    @IBOutlet weak var policyHelpStackView: UIStackView!
    @IBOutlet weak var policyButtonContainerView: ButtonWithImage!
    @IBOutlet weak var helpButtonContainerView: ButtonWithImage!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        formatBasicViews()
    }
    private func formatBasicViews(){
        self.contentView.backgroundColor = AppColors.lightBackground
        mainView.layer.cornerRadius = 10.0
        remainingTimeView.backgroundColor = UIColor.clear
    }
    func setupCell(cellData: PolicyEventVM){
        formatPolicyLabel(title: "Active policy")
        formatRemainingTimeLabel(time: cellData.remainingTime)
        formatButton(buttonType: .help)
        formatButton(buttonType: .policy)
    }
    private func formatPolicyLabel(title: String){
        let font = AppFonts.labelFont(labelType: .tableViewHeader).font
        let color = AppColors.textColor(labelType: .headerInTableCell).color
        policyLabel.attributedText = title.getAttributedTitle(font: font, textColor: color)
    }
    private func formatRemainingTimeLabel(time: String){
        remainingTimeLabel.numberOfLines = 2
        var font = AppFonts.labelFont(labelType: .tableViewHeader).font
        var color = AppColors.textColor(labelType: .regularInTableCell).color
        let firstLine = "Time remaining".getAttributedTitle(font: font, textColor: color)
        font = AppFonts.labelFont(labelType: .subHeaderInTableCell).font
        color = AppColors.textColor(labelType: .subHeaderInTableCell).color
        let secondLine = time.getAttributedTitle(font: font, textColor: color)
        guard let firstString = firstLine, let secondString = secondLine else { return }
        let result = NSMutableAttributedString()
        result.append(firstString)
        result.append(NSAttributedString(string: "\n"))
        result.append(secondString)
        remainingTimeLabel.attributedText = result
    }
    private func formatButton(buttonType: ActivePolicyButtonType){
        var title: String?
        var icon: UIImage?
        var color: UIColor?
        var button: ButtonWithImage?
        let font = AppFonts.labelFont(labelType: .headerInImageButton).font
        let backgroundColor = AppColors.lightBackground
        
        switch buttonType {
        case .help:
            title = "Get help"
            icon = UIImage(named: "help")
            color = UIColor.red
            button = helpButtonContainerView
        case .policy:
            title = "Policy"
            icon = UIImage(named: "Icon-22")
            color = AppColors.textColor(labelType: .regularInTableCell).color
            button = policyButtonContainerView
        }
        
        let attributedTitle = title?.getAttributedTitle(font: font, textColor: color)
        button?.setAttributedTitle(attributedTitle, for: .normal)
        button?.setImage(icon, for: .normal)
        button?.setBackgroundColor(color: backgroundColor)
        //policyButtonContainerView.addTarget(self, action: #selector(motorButtonPressed(sender:)), for: .touchDown)
    }
}
