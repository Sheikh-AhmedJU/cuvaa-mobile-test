//
//  PolicyViewModel.swift
//  App
//
//  Created by Sheikh Ahmed on 19/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit
class PolicyViewModel{
    private var allPolicies: [PolicyEventVM] = []
    private var activePolicies: [PolicyEventVM] = []
    private var previousPolicies: [PolicyEventVM] = []
    init(policies: [PolicyEventVM]){
        let _policies = policies.filter {
            !$0.timeStamp.isEmpty
        }.sorted{
            (lhs, rhs) in
            guard let leftDate = lhs.timeStamp.getDateAndTime(),
                let rightDate = rhs.timeStamp.getDateAndTime() else {
                    return false
            }
            return leftDate > rightDate
        }
        
        self.allPolicies = _policies
        activePolicies = _policies.filter({ $0.isActivePolicy})
        previousPolicies = _policies.filter({ !$0.isActivePolicy && !$0.isFinancialTransaction})
    }
    //get navigation Background color
    func getNavigationBarTintColor()->UIColor?{
        return AppColors.policyNavigationBackground
    }
    // get the navigation bar title text attributes
    func getNavigationBarTitleTextAttributes()->[NSAttributedString.Key: NSObject]?{
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: AppFonts.labelFont(labelType: .tableViewHeader).font ?? UIFont()]
        
        return attributes
    }
    // get the background color
    func getBackgroundColor()->UIColor?{
        return AppColors.lightBackground
    }
    // get the tableViewBackgroundColor
    func getTableViewBackgroundColor()->UIColor?{
        return AppColors.lightBackground
    }
    // get the navigation left navigation button
    func getNavigationButton(buttonPosition: NavigationButtonPosition)->UIImage?{
        switch buttonPosition {
        case .left:
            return UIImage(named: "Icon-23")
        case .right:
            return UIImage(named: "Icon-21")
        }
    }
    // get the view controller title
    func getViewControllerTitle()->String?{
        return "Vehicle profile"
    }
    // get background color for logo container view
    func getLogoContainerBackgroundView()->UIColor? {
        return AppColors.policyNavigationBackground
    }
    // get the logo
    func getLogoImage()->UIImage? {
        return allPolicies.first?.vehicleLogo
    }
    // get the background for logo
    func getLogoBackgroundColor()->UIColor?{
        return UIColor.white
    }
    // get the model
    func getModel()->NSAttributedString?{
        var font = AppFonts.labelFont(labelType: .subHeaderInTableCell).font
        var color = UIColor.white
        
        let modelWithColor = allPolicies.first?.vehicleMakeWithModel.getAttributedTitle(font: font, textColor: color)
        
        font = AppFonts.bigRegistrationPlate
        color = UIColor.white
        let registrationPlate = allPolicies.first?.registrationPlate.getAttributedTitle(font: font, textColor: color)
        guard let model = modelWithColor, let plate = registrationPlate else { return nil }
        let result = NSMutableAttributedString()
        result.append(model)
        result.append(NSAttributedString(string: "\n"))
        result.append(plate)
        return result
    }
    // get number of policies
    func getNumberOfPolicies()->NSAttributedString?{
        var font = AppFonts.SF.regular(ofSize: 13)
        var color = UIColor.white
        let numberOfPolicies = String(allPolicies.filter({ $0.isActivePolicy}).count)
            .getAttributedTitle(font: font, textColor: color)
        font = AppFonts.SF.regular(ofSize: 13)
        color = UIColor.white
        let firstLine = "Total policies".getAttributedTitle(font: font, textColor: color)
        guard let policies = numberOfPolicies, let fLine = firstLine else { return nil }
        let result = NSMutableAttributedString()
        result.append(fLine)
        result.append(NSAttributedString(string: "\n"))
        result.append(policies)
        return result
    }
    func formatButton(button: UIButton){
        let isExtendedPolicy = allPolicies.filter {$0.isActivePolicy}.compactMap { $0
        }.count > 0
        
        let buttonTitle = isExtendedPolicy ? "Extend cover" : "Insure cover"
        let buttonType = isExtendedPolicy ? ButtonType.extend : ButtonType.insure
       // button.backgroundColor = buttonType == .extend ? AppColors.buttonBackgroundColor(buttonType: .extend).color : AppColors.buttonTextColor(buttonType: .insure).color
         button.backgroundColor =  AppColors.buttonBackgroundColor(buttonType: .extend).color
        button.layer.cornerRadius = 5.0
        let font = AppFonts.buttonFont(buttonType: buttonType).font
        let color = AppColors.buttonTextColor(buttonType: .extend).color
        let attributedText = buttonTitle.getAttributedTitle(font: font, textColor: color)
        button.setAttributedTitle(attributedText, for: .normal)
        button.isUserInteractionEnabled = false
    }
    func getNumberOfSections()->Int{
        if activePolicies.isEmpty && previousPolicies.isEmpty {
            return 0
        } else if activePolicies.isEmpty || previousPolicies.isEmpty{
            return 1
        }
        return 2
    }
    func getNumberOfRowsInSection(for section: Int)->Int {
        let numberOfSections = getNumberOfSections()
        guard section < numberOfSections else { return 0}
        switch section {
        case 0:
            switch numberOfSections {
            case 1:
                guard !activePolicies.isEmpty else {
                    return previousPolicies.count
                }
                return activePolicies.count
            default:
                return activePolicies.count
            }
        default: return previousPolicies.count
        }
    }
    func getHeaderView(for section: Int)->UIView?{
        let numberOfSections = getNumberOfSections()
        guard section < numberOfSections else { return nil}
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y: 10, width: 320, height: 20)
        var headerTitle: String?
        switch numberOfSections{
        case 1: headerTitle = activePolicies.count > 0 ?
            activePolicies.count > 1 ? "Active driving policies" : "Active driving policy"
            :
            previousPolicies.count > 1 ? "Previous driving policies" : "Previous driving policy"
        case 2:
            headerTitle = section == 0 ?
                activePolicies.count > 1 ? "Active driving policies" : "Active driving policy"
                :
                previousPolicies.count > 1 ? "Previous driving policies" : "Previous driving policy"
        default: break
        }
        
        let color = AppColors.textColor(labelType: .tableViewHeader).color
        let font = AppFonts.labelFont(labelType: .tableViewHeader).font
        headerLabel.attributedText = headerTitle?.getAttributedTitle(font: font, textColor: color)
        let headerView = UIView()
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = AppColors.lightBackground
        return headerView
    }
    func getheightForHeaderInSection(section: Int)->CGFloat{
        guard getNumberOfRowsInSection(for: section) > 0 else { return 0.001 }
        return 35
    }
    func getCellData(for indexPath: IndexPath)->PolicyEventVM?{
        let numberOfSections = getNumberOfSections()
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            switch numberOfSections {
            case 1:
                guard row < activePolicies.count else {
                    guard row < previousPolicies.count else {
                        return nil
                    }
                    return previousPolicies[row]
                }
                return activePolicies[row]
            default:
                return activePolicies[row]
            }
        default: return previousPolicies[row]
        }
    }
    func getModelsForReciept(for indexPath: IndexPath)->[PolicyEventVM]{
        let policyID = getCellData(for: indexPath)?.policyID
        return allPolicies.filter { $0.policyID == policyID && $0.isFinancialTransaction}
    }
}
