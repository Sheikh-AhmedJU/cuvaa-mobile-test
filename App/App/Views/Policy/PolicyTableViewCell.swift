//
//  PolicyTableViewCell.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class PolicyTableViewCell: UITableViewCell, NibBased {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var timesRemainingViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var vehicleModelView: UIView!
    @IBOutlet weak var totalPoliciesLabel: UILabel!
    @IBOutlet weak var registrationPlateLabel: UILabel!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var policyTypeButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var remainingTimeView: UIView!
    @IBOutlet weak var registrationView: UIView!
    @IBOutlet weak var remainingDurationLabel: UILabel!
    
    @IBOutlet weak var circularRemainingTimeView: CircularProgressView!
    private var remainingTime: Double = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        formatBasicViews()
    }
    private func formatBasicViews(){
        self.contentView.backgroundColor = AppColors.lightBackground
        mainView.layer.cornerRadius = 10.0
        logoView.image = nil
        remainingDurationLabel.text = nil
        registrationPlateLabel.text = nil
        totalPoliciesLabel.text = nil
        modelName.text = nil
        policyTypeButton.setTitle(nil, for: .normal)
        vehicleModelView.backgroundColor = UIColor.clear
        buttonContainerView.backgroundColor = UIColor.clear
        registrationView.backgroundColor = UIColor.clear
        remainingTimeView.backgroundColor = UIColor.clear
        circularRemainingTimeView.trackClr = UIColor.clear
        circularRemainingTimeView.progressClr = UIColor.clear
    }
    public func applyCellData(data: [PolicyEventVM]){
        guard data.count > 0 else { return }
        let isActive = Array(Set(data.map {
            $0.isActivePolicy
            })).first ?? false
        formatButton(isExtendedPolicy: isActive)
        
        let vehicleMake = Array(Set(data.map {
            $0.vehicleMake
            })).first ?? ""
        let vehicleModelWithColor = Array(Set(data.map {
            $0.vehicleModelWithColor
            })).first ?? ""
        formatVehicleModelAndColor(make: vehicleMake, modelAndColor: vehicleModelWithColor)
    
        formatTotalPolicies(totalPolicies: data.count)
        
        let registrationPlate = Array(Set(data.map {
            $0.registrationPlate
            })).first ?? ""
        formatRegistrationPlate(plate: registrationPlate)
        
        logoView.image = data.first?.vehicleLogo
        guard let remainingTime = data.first?.remainingTime,
            let policyDuration = data.first?.policyDuration,
            let policyRemainingTime = data.first?.policyRemainingDuration
            else { return}
        self.remainingTime = Double(policyRemainingTime)  / Double(policyDuration)
        formatRemainingTime(remainingTime: remainingTime)
    }
    private func formatButton(isExtendedPolicy: Bool){
        let buttonTitle = isExtendedPolicy ? "Extend" : "Insure"
        let buttonType = isExtendedPolicy ? ButtonType.extend : ButtonType.insure
        buttonContainerView.backgroundColor = AppColors.buttonBackgroundColor(buttonType: buttonType).color
        buttonContainerView.layer.cornerRadius = 15.0
        let font = AppFonts.buttonFont(buttonType: buttonType).font
        let color = AppColors.buttonTextColor(buttonType: buttonType).color
        let attributedText = buttonTitle.getAttributedTitle(font: font, textColor: color)
        policyTypeButton.setAttributedTitle(attributedText, for: .normal)
        policyTypeButton.isUserInteractionEnabled = false 
    }
    private func formatVehicleModelAndColor(make: String, modelAndColor: String){
        modelName.numberOfLines = 2
        var font = AppFonts.labelFont(labelType: .headerInTableCell).font
        var color = AppColors.textColor(labelType: .headerInTableCell).color
        let makeAttributedString = make.getAttributedTitle(font: font, textColor: color)
        font = AppFonts.labelFont(labelType: .subHeaderInTableCell).font
        color = AppColors.textColor(labelType: .subHeaderInTableCell).color
        let modelAndColorAttributedString = modelAndColor.getAttributedTitle(font: font, textColor: color)
        guard let mString = makeAttributedString, let mcString = modelAndColorAttributedString else { return }
        let result = NSMutableAttributedString()
        result.append(mString)
        result.append(NSAttributedString(string: "\n"))
        result.append(mcString)
        modelName.attributedText = result
    }
    private func formatRegistrationPlate(plate: String){
        registrationPlateLabel.numberOfLines = 2
        let font = AppFonts.labelFont(labelType: .lightGrey).font
        let color = AppColors.textColor(labelType: .lightGrey).color
        let firstLine = "Reg plate".getAttributedTitle(font: font, textColor: color)
        let secondLine = plate.getAttributedTitle(font: font, textColor: color)
        guard let firsString = firstLine, let secondString = secondLine else { return }
        let result = NSMutableAttributedString()
        result.append(firsString)
        result.append(NSAttributedString(string: "\n"))
        result.append(secondString)
        registrationPlateLabel.attributedText = result
    }
    private func formatTotalPolicies(totalPolicies: Int){
        totalPoliciesLabel.numberOfLines = 2
        let font = AppFonts.labelFont(labelType: .lightGrey).font
        let color = AppColors.textColor(labelType: .lightGrey).color
        let firstLine = "Total policies".getAttributedTitle(font: font, textColor: color)
        let secondLine = String(totalPolicies).getAttributedTitle(font: font, textColor: color)
        guard let firsString = firstLine, let secondString = secondLine else { return }
        let result = NSMutableAttributedString()
        result.append(firsString)
        result.append(NSAttributedString(string: "\n"))
        result.append(secondString)
        totalPoliciesLabel.attributedText = result
    }
    private func formatRemainingTime(remainingTime: String) {
        remainingDurationLabel.isHidden = remainingTime.isEmpty
        remainingTimeView.isHidden = remainingTime.isEmpty
        guard !remainingTime.isEmpty else {
            timesRemainingViewConstraints.constant = 0
            return
        }
        timesRemainingViewConstraints.constant = 20
        let font = AppFonts.labelFont(labelType: .regularInTableCell).font
        let color = AppColors.textColor(labelType: .regularInTableCell).color
        remainingDurationLabel.attributedText = remainingTime.getAttributedTitle(font: font, textColor: color)
        
        circularRemainingTimeView.trackClr = AppColors.lightBackground
        circularRemainingTimeView.progressClr = AppColors.textColor(labelType: .regularInTableCell).color ?? UIColor.blue
        circularRemainingTimeView.setProgressWithAnimation(duration: 0.3, value: Float(1.0 - self.remainingTime))
    }
}
