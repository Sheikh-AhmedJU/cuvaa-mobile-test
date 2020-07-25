//
//  PolicyViewController.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var logoView: UIView!
    
    @IBOutlet weak var logoContainerView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var logoImageBackgroundView: UIView!
    
    @IBOutlet weak var policyCountView: UIView!
    @IBOutlet weak var policyCountLabel: UILabel!
    
    @IBOutlet weak var policyTypeButtonContainerView: UIView!
    @IBOutlet weak var policyTypeButton: UIButton!
    
    
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PolicyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setViewControllerTitle()
        setupBackGroundColor()
        setUpNavigationsButtons()
        setupLogoContainerView()
        setupNumberOfPolicies()
        setupPolicyTypeButton()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        setUpNavigationsButtons()
    }
    private func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = viewModel?.getNavigationBarTintColor()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = viewModel?.getNavigationBarTitleTextAttributes()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    private func setViewControllerTitle(){
        self.title = viewModel?.getViewControllerTitle()
    }
    private func setupBackGroundColor(){
        view.backgroundColor = viewModel?.getBackgroundColor()
    }
    private func setUpNavigationsButtons(){
        let leftImage = viewModel?.getNavigationButton(buttonPosition: .left)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(goBack))
        let rightImage = viewModel?.getNavigationButton(buttonPosition: .right)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    private func setupLogoContainerView(){
        vehicleModelLabel.numberOfLines = 0
        logoContainerView.backgroundColor = viewModel?.getLogoContainerBackgroundView()
        logoView.backgroundColor = viewModel?.getLogoContainerBackgroundView()
        logoImage.image = viewModel?.getLogoImage()
        logoImage.setRounded()
        logoImageBackgroundView.setRounded()
        logoImageBackgroundView.backgroundColor = viewModel?.getLogoBackgroundColor()
        vehicleModelLabel.attributedText = viewModel?.getModel()
    }
    private func setupNumberOfPolicies(){
        policyCountView.backgroundColor = viewModel?.getLogoContainerBackgroundView()
        policyCountView.clipsToBounds = true
        policyCountView.layer.cornerRadius = 50.0
        policyCountView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        policyCountLabel.numberOfLines = 0
        policyCountLabel.attributedText = viewModel?.getNumberOfPolicies()
        
    }
    private func setupPolicyTypeButton(){
        viewModel?.formatButton(button: policyTypeButton)
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActivePolicyTableViewCell.self)
        tableView.register(PreviousPolicyTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableContainerView.backgroundColor = viewModel?.getTableViewBackgroundColor()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
    }
    // MARK:- reload data
    private func reloadData(){
        tableView.reloadData()
    }
}
extension PolicyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = viewModel?.getNumberOfSections() ?? 0
        return count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.getNumberOfRowsInSection(for: section) ?? 0
        return count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel?.getHeaderView(for: section)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel?.getheightForHeaderInSection(section: section) ?? 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        guard let cellData = viewModel?.getCellData(for: indexPath)
        else {
            return UITableViewCell()
        }
        if cellData.isActivePolicy {
            let activeCell: ActivePolicyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            activeCell.setupCell(cellData: cellData)
            cell = activeCell
        } else {
            let previousCell: PreviousPolicyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            previousCell.setupCell(cellData: cellData)
            cell = previousCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: ReceiptViewController = ReceiptViewController.instantiate()
        if let policies = viewModel?.getModelsForReciept(for: indexPath) {
            let viewModel = RecieptViewModel(policies: policies)
            vc.viewModel = viewModel
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
