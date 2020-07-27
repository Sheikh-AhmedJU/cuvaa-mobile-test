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
    var title: String {
        switch self {
        case .help: return "Get help"
        case .policy: return "Policy"
        }
    }
    var icon: UIImage?{
        switch self{
        case .help: return UIImage(named: "help")
        case .policy: return UIImage(named: "Icon-22")
        }
    }
    var color: UIColor?{
        switch self {
        case .help: return UIColor.red
        case .policy: return AppColors.textColor(labelType: .regularInTableCell).color
        }
    }
}
class ActivePolicyTableViewCell: UITableViewCell, NibBased {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var policyTypeView: UIView!
    @IBOutlet weak var policyLabel: UILabel!
    
    @IBOutlet weak var remainingTimeView: UIView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
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
        circularProgressView.progressClr = UIColor.clear
        circularProgressView.trackClr = UIColor.clear
    }
    func setupCell(cellData: PolicyEventVM){
        formatPolicyLabel(title: "Active policy")
        formatRemainingTimeViews(totalDuration: cellData.policyDuration, remainingTime: cellData.policyRemainingDuration)
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
        var color = AppColors.textColor(labelType: .headerInTableCell).color
        let firstLine = "Time remaining".getAttributedTitle(font: font, textColor: color)
        font = AppFonts.labelFont(labelType: .headerInTableCell).font
        color = AppColors.textColor(labelType: .regularInTableCell).color
        let secondLine = time.getAttributedTitle(font: font, textColor: color)
        guard let firstString = firstLine, let secondString = secondLine else { return }
        let result = NSMutableAttributedString()
        result.append(firstString)
        result.append(NSAttributedString(string: "\n"))
        result.append(secondString)
        remainingTimeLabel.attributedText = result
    }
    private func formatRemainingTimeViews(totalDuration: Int, remainingTime: Int){
        formatRemainingTimeLabel(time: remainingTime.toTimeDuration())
        circularProgressView.trackClr = AppColors.lightBackground
        circularProgressView.progressClr = AppColors.textColor(labelType: .regularInTableCell).color ?? UIColor.blue
        let remainingTimeInPercentage = Float(remainingTime) / Float(totalDuration)
        circularProgressView.setProgressWithAnimation(duration: 0.3, value: 1.0 - remainingTimeInPercentage)
    }
    private func formatButton(buttonType: ActivePolicyButtonType){
        var button: ButtonWithImage?
        let font = AppFonts.labelFont(labelType: .headerInImageButton).font
        let backgroundColor = AppColors.lightBackground
        switch buttonType {
        case .help:
            button = helpButtonContainerView
        case .policy:
            button = policyButtonContainerView
        }
        let attributedTitle = buttonType.title.getAttributedTitle(font: font, textColor: buttonType.color)
        button?.setAttributedTitle(attributedTitle, for: .normal)
        button?.setImage(buttonType.icon, for: .normal)
        button?.setBackgroundColor(color: backgroundColor)
    }
}
