//
//  RecieptViewModel.swift
//  App
//
//  Created by Sheikh Ahmed on 24/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit

enum PolicyStatus{
    case voided
    case active
    case expired
    var title: String {
        switch self{
        case .active: return "This policy is still active"
        case .expired: return "This policy has expired"
        case .voided: return "This policy has been voided"
        }
    }
    var backgroundColor: UIColor?{
        switch self {
        case .active: return AppColors.activePolicyButtonBackground
        case .expired: return AppColors.darkBackground
        case .voided: return AppColors.voidedPolicyBackgroundColor
        }
    }
}
enum ReceiptTitles{
    case premium
    case premiumTax 
    case adminFee
    case totalPaid
    case grandTotal
    var text: String {
        switch self {
        case .adminFee: return "Admin fee"
        case .grandTotal: return "Grand total"
        case .premium: return "Insurance premium"
        case .premiumTax: return "Insurance premium tax"
        case .totalPaid: return "Total paid"
        }
    }
}


class RecieptViewModel{
    private var allPolicies: [PolicyEventVM] = []
    private var policyStatus: PolicyStatus
    init(policies: [PolicyEventVM]){
        let _policies = policies.filter {
            !$0.timeStamp.isEmpty && $0.totalPaid != 0
        }.sorted{
            (lhs, rhs) in
            guard let leftDate = lhs.timeStamp.getDateAndTime(),
                let rightDate = rhs.timeStamp.getDateAndTime() else {
                    return false
            }
            return leftDate < rightDate
        }
        self.allPolicies = _policies
        guard policies.filter({ $0.isFinancialTransaction  && ($0.insurancePremium < 0) }).count > 0 else {
            guard policies.filter({ $0.isActivePolicy}).count > 0 else {
                policyStatus = .expired
                return
            }
            policyStatus = .active
            return
        }
        policyStatus = .voided
        
    }
    // get the navigationbar tint color
    func getNavigationBarTintColor()->UIColor?{
        return AppColors.recieptNavigationBackground
    }
    // get the navigation bar title text attributes
    func getNavigationBarTitleTextAttributes()->[NSAttributedString.Key: NSObject]?{
        let attributes = [NSAttributedString.Key.foregroundColor: AppColors.textColor(labelType: .headerInTableCell).color ?? UIColor.black, NSAttributedString.Key.font: AppFonts.labelFont(labelType: .tableViewHeader).font ?? UIFont()]
        
        return attributes
    }
    // get the navigation left navigation button
    func getNavigationButton(buttonPosition: NavigationButtonPosition)->UIImage?{
        switch buttonPosition {
        case .left:
            return UIImage(named: "Icon-29")
        case .right:
            return UIImage(named: "Icon-21")
        }
    }
    // get the view controller title
    func getViewControllerTitle()->String?{
        return "Receipt"
    }
    // get the policy status container view background color
    func getPolicyContainerBackgroundColor()->UIColor?{
        return policyStatus.backgroundColor
    }
    // get the policy status
    func getPolicyStatusTitle()->NSAttributedString?{
        let font = AppFonts.labelFont(labelType: .tableViewHeader).font
        let color = UIColor.white
        return self.policyStatus.title.getAttributedTitle(font: font, textColor: color)
    }
    // get the tableViewBackgroundColor
    func getTableViewBackgroundColor()->UIColor?{
        return AppColors.lightBackground
    }
    // get the number of sections
    func getNumberOfSections()->Int{
        return allPolicies.count + 1
    }
    // get the number of rows in section
    func getNumberOfRows(in section: Int)->Int{
        let numberOfSections = getNumberOfSections()
        return (section == numberOfSections - 1) ? 1 : 4
    }
    // get the header view
    func getHeaderView(for section: Int)->UIView?{
        let numberOfSections = getNumberOfSections()
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 15, y: 20, width: 320, height: 20)
        let headerView = UIView()
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = AppColors.lightBackground
        guard section < numberOfSections - 1
            else {
            return headerView
        }
        let datePart = allPolicies[section].policyUpdateDate.split(separator: ",").last ?? ""
        let timePart = allPolicies[section].policyUpdateTime
        let headerTitle = "\(datePart) at \(timePart)"
        
        let color = AppColors.textColor(labelType: .tableViewHeader).color
        let font = AppFonts.labelFont(labelType: .tableViewHeader).font
        headerLabel.attributedText = headerTitle.getAttributedTitle(font: font, textColor: color)
        return headerView
    }
    // get height for header
    func getheightForHeaderInSection(section: Int)->CGFloat?{
        let numberOfSections = getNumberOfSections()
        return (section == numberOfSections - 1) ? 15 : 45.0
    }
    // get cell data for indexPath
    func getCellData(indexPath: IndexPath)->(NSAttributedString?, NSAttributedString?){
        let row = indexPath.row
        let section = indexPath.section
        let numberOfSections = getNumberOfSections()
        var font = AppFonts.labelFont(labelType: .tableViewHeader).font
        var color = AppColors.textColor(labelType: .headerInTableCell).color
        guard section != numberOfSections - 1 else {
            let total = allPolicies.compactMap { $0.totalPaid
            }.reduce(0, +).toCurrency().getAttributedTitle(font: font, textColor: color)
            let firstPart = ReceiptTitles.grandTotal.text.getAttributedTitle(font: font, textColor: color)
            return (firstPart, total)
        }
        let cellData = allPolicies[section]
        var firstPart: String?
        var secondPart: String?
        font = AppFonts.labelFont(labelType: .regularInTableCell).font
        color = AppColors.textColor(labelType: .headerInTableCell).color
        switch row{
        case 0:
            firstPart = ReceiptTitles.premium.text
            secondPart = cellData.insurancePremium.toCurrency()
        case 1:
            firstPart = ReceiptTitles.premiumTax.text
            secondPart = cellData.insurancePremiumTax.toCurrency()
        case 2:
            firstPart = ReceiptTitles.adminFee.text
            secondPart = cellData.adminFee.toCurrency()
        case 3:
            font = AppFonts.labelFont(labelType: .tableViewHeader).font
            firstPart = ReceiptTitles.totalPaid.text
            secondPart = cellData.totalPaid.toCurrency()
        default: break
        }
        return (firstPart?.getAttributedTitle(font: font, textColor: color), secondPart?.getAttributedTitle(font: font, textColor: color))
    }
}
