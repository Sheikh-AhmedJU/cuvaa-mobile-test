//
//  HomeViewModel.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit
protocol HomeViewOperations {
    func fetchPolicies(completion: @escaping (Result<Bool, APIError>)->Void)
}
class HomeViewModel{
    private let service = PolicyEventService()
    private var _allEvents: PolicyEvents?
    private var _allViewModels: [PolicyEventVM] = []
    private var activePolicies: [PolicyEventVM] = []
    private var inactivePolicies: [PolicyEventVM] = []
    private var vehicleWithActiveProfiles: [String] = []
    private var vehicleWithoutActiveProfiles: [String] = []
    let dbManager: DataBaseManager
    let policyRepo: PolicyRepository
    var loadFromLocalRepository: Bool = false
    init(dbManager: DataBaseManager = RealmDataBaseManager(RealmProvider.default)){
        self.dbManager = dbManager
        self.policyRepo = PolicyRepository(dbManager: dbManager)
    }
    
    //get navigationBar Color
    func getNavigationBarTintColor()->UIColor?{
        return AppColors.darkBackground
    }
    
    // get the navigation bar title text attributes
    func getNavigationBarTitleTextAttributes()->[NSAttributedString.Key: NSObject]?{
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: AppFonts.labelFont(labelType: .tableViewHeader).font ?? UIFont()]
        
        return attributes
    }
    // get the navigation left navigation button
    func getNavigationButton(buttonPosition: NavigationButtonPosition)->UIImage?{
        switch buttonPosition {
        case .left:
            return UIImage(named: "Icon-20")
        case .right:
            return UIImage(named: "Icon-21")
        }
    }
    
    // get the background image for the view controller
    func getBackgroundColor()->UIColor?{
        return AppColors.darkBackground
    }
    // get the image for the navigation button
    func getImageforButton(asset: AppAssets)->UIImage?{
        return asset.image
    }
    // get the transport type button
    func getTransportButtonTitle(title: String, isAvailable: Bool? = nil)->NSAttributedString? {
        let font = AppFonts.labelFont(labelType: .headerInImageButton).font
        let textColor = AppColors.textColor(labelType: .headerInImageButton).color
        guard let isAvailable = isAvailable, let titleAttributedText = title.getAttributedTitle(font: font, textColor: textColor), let bulletText = "Available now".getAttributedBullet(isAvailable: isAvailable)else {
            return title.getAttributedTitle(font: font, textColor: textColor)
        }
        let result = NSMutableAttributedString()
        result.append(titleAttributedText)
        result.append(bulletText)
        return result
    }
    func getTrasportButtonBackgroundColor()->UIColor?{
        return AppColors.lightBackground
    }
    func getTableViewBackgroundColor()->UIColor? {
        return AppColors.lightBackground
    }
    func getAllPolicies(for registrationPlate: String?)->[PolicyEventVM]{
        let result = _allViewModels
        return result
    }
    func getCellData(for indexPath: IndexPath)->[PolicyEventVM] {
        var result: [PolicyEventVM] = []
        let section = indexPath.section
        let row = indexPath.row
        let numberOfSections = getNumberOfSections()
        guard section < numberOfSections else {return result}
        switch section{
        case 0:
            switch numberOfSections {
            case 1:
                result = inactivePolicies.filter({ $0.registrationPlate == vehicleWithoutActiveProfiles[row]
                })
            default:
                guard row < vehicleWithActiveProfiles.count
                    else { return result }
                result = activePolicies.filter({
                    $0.registrationPlate == vehicleWithActiveProfiles[row]
                })
            }
        case 1:
            guard row < vehicleWithoutActiveProfiles.count
                else { return result }
            result = inactivePolicies.filter({ $0.registrationPlate == vehicleWithoutActiveProfiles[row]
            })
        default:
            break
        }
        return result
    }
    
    func getHeaderView(for section: Int)->UIView?{
        guard section < getNumberOfSections() else { return nil}
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 35, y: 15, width: 320, height: 20)
        var headerTitle: String?
        switch getNumberOfSections(){
        case 1: headerTitle = vehicleWithActiveProfiles.count > 0 ? "Active policies" : "Vehicles"
        case 2:
            headerTitle = section == 0 ? "Active policies" : "Vehicles"
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
    func getNumberOfRowsInSection(for section: Int)->Int {
        let numberOfSections = getNumberOfSections()
        var count = 0
        switch numberOfSections {
        case 1:
            count = vehicleWithActiveProfiles.count > 0 ? vehicleWithActiveProfiles.count : vehicleWithoutActiveProfiles.count
        case 2: count = section == 0 ? vehicleWithActiveProfiles.count : vehicleWithoutActiveProfiles.count
        default: break
        }
        return count
    }
    func getNumberOfSections()->Int {
        var count = 0
        count += activePolicies.count > 0 ? 1 : 0
        count += inactivePolicies.count > 0 ? 1 : 0
        return count
    }
    func getHeightForHeaderInSection(section: Int)->CGFloat{
        guard getNumberOfRowsInSection(for: section) > 0 else { return 0.001 }
        return 35
    }
}
extension HomeViewModel: HomeViewOperations {
    func fetchPolicies(completion: @escaping (Result<Bool, APIError>)->Void) {
        switch loadFromLocalRepository {
        case true :
            self.policyRepo.getAllPolicies { (events) in
                self.analysePolicyEvents(policyEvents: events) { (_) in
                    completion(.success(true))
                }
            }
        case false:
            service.getPolicyEvents { [weak self] (result) in
                guard let `self` = self else {return}
                switch result {
                case .success(let models):
                    guard let policyEvents = models else {
                        completion(.failure(.other(message: "Failed to load data")))
                        return
                    }
                    self.analysePolicyEvents(policyEvents: policyEvents) { (_) in
                        completion(.success(true))
                        if !policyEvents.isEmpty {
                            self.policyRepo.deleteAllPolicies()
                            for object in policyEvents {
                                self.policyRepo.savePolicy(policy: object)
                            }
                        }
                    }
                case .failure(let error):
                    self.policyRepo.getAllPolicies { (events) in
                        self.analysePolicyEvents(policyEvents: events) { (_) in
                            completion(.success(true))
                        }
                    }
                    completion(.failure(error))
                }
            }
        }
        // look for local
        
        // else look for remote
        
    }
    private func analysePolicyEvents(policyEvents: PolicyEvents, completion: @escaping(Bool)->Void){
        self._allEvents = policyEvents
        let allViewModels = policyEvents.compactMap {
            PolicyEventVM(policyEventModel: $0)
        }
        self._allViewModels = allViewModels
        self.vehicleWithActiveProfiles = Array(Set(allViewModels.filter({ $0.isActivePolicy})
            .compactMap { $0.registrationPlate}
            .filter({!$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            })))
        
        self.activePolicies = allViewModels.filter({
            self.vehicleWithActiveProfiles.contains($0.registrationPlate) && $0.isActivePolicy
        })
        
        self.vehicleWithoutActiveProfiles = Array(Set(allViewModels.filter({ !$0.isActivePolicy })
            .compactMap { $0.registrationPlate}
            .filter({ !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }).filter({ !self.vehicleWithActiveProfiles.contains($0)
            })
        ))
        self.inactivePolicies = allViewModels.filter({
            self.vehicleWithoutActiveProfiles.contains($0.registrationPlate) && !$0.isActivePolicy && !self.vehicleWithActiveProfiles.contains($0.registrationPlate)
        })
        completion(true)
    }
}
