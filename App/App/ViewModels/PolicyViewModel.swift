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
    private var registrationPlate: String?
    private var makeWithModel: String?
    private var vehicleLogo: UIImage?
    private var policyIdList: [String] = []
    private var allPolicies: [PolicyEventVM] = []
    private var activePolicies: [String] = []
    private var previousPolicies: [String] = []
    init(policies: [PolicyEventVM], registrationPlate: String?, makeWithModel: String?, vehicleLogo: UIImage?){
        policyIdList = Array(Set(policies.filter({
            $0.registrationPlate == registrationPlate})
            .compactMap({ $0.policyID })))
        let _policies = policies.filter {
            !$0.timeStamp.isEmpty && policyIdList.contains($0.policyID)
        }.sorted{
            (lhs, rhs) in
            guard let leftDate = lhs.timeStamp.getDateAndTime(),
                let rightDate = rhs.timeStamp.getDateAndTime() else {
                    return false
            }
            return leftDate > rightDate
        }
        self.registrationPlate = registrationPlate
        self.makeWithModel = makeWithModel
        self.vehicleLogo = vehicleLogo
        self.allPolicies = _policies
        activePolicies = _policies.filter({ $0.isActivePolicy}).compactMap({ $0.policyID})
        previousPolicies = _policies.filter({ !$0.isActivePolicy && !$0.isFinancialTransaction && !$0.isCancelled}).compactMap({ $0.policyID})
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
        return self.vehicleLogo
    }
    // get the background for logo
    func getLogoBackgroundColor()->UIColor?{
        return UIColor.white
    }
    // get the model
    func getModel()->NSAttributedString?{
        var font = AppFonts.labelFont(labelType: .subHeaderInTableCell).font
        var color = UIColor.white
        
        let makeWithModel = self.makeWithModel?.getAttributedTitle(font: font, textColor: color)
        
        font = AppFonts.bigRegistrationPlate
        color = UIColor.white
        let registrationPlate = self.registrationPlate?.getAttributedTitle(font: font, textColor: color)
        guard let model = makeWithModel, let plate = registrationPlate else { return nil }
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
        button.backgroundColor = buttonType == .extend ? AppColors.buttonBackgroundColor(buttonType: .extend).color : AppColors.darkBackground
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
                    return allPolicies.filter{ $0.policyID == previousPolicies[row] && !$0.isFinancialTransaction}.first
                }
                return allPolicies.filter{ $0.policyID == activePolicies[row] && !$0.isFinancialTransaction}.first
            default:
                return allPolicies.filter{ $0.policyID == activePolicies[row] && !$0.isFinancialTransaction}.first
            }
        default: return allPolicies.filter{ $0.policyID == previousPolicies[row] && !$0.isFinancialTransaction}.first
        }
    }
    func getModelsForReciept(for indexPath: IndexPath)->[PolicyEventVM]{
        let cellData = getCellData(for: indexPath)
        let policyID = cellData?.policyID
        let isCancelled = cellData?.isCancelled ?? false
        return isCancelled ? allPolicies.filter { $0.policyID == policyID && $0.isFinancialTransaction} :
            allPolicies.filter { $0.policyID == policyID && ($0.isFinancialTransaction || $0.isNewPolicy) && !$0.isCancelled}
    }
    func isPolicyCancelled(policyID: String)->Bool{
        return allPolicies.filter { $0.policyID == policyID}.filter { $0.isCancelled}.count > 0
    }
}
