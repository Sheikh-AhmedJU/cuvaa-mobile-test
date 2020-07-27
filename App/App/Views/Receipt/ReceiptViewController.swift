//
//  ReceiptViewController.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var policyStatusContainerView: UIView!
    @IBOutlet weak var policyStatusLabel: UILabel!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RecieptViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setUpNavigationsButtons()
        setViewControllerTitle()
        setupPolicyStatusViews()
        setupTableView()
    }
    private func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = viewModel?.getNavigationBarTintColor()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = viewModel?.getNavigationBarTitleTextAttributes()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    private func setUpNavigationsButtons(){
        let leftImage = viewModel?.getNavigationButton(buttonPosition: .left)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(goBack))
        let rightImage = viewModel?.getNavigationButton(buttonPosition: .right)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = AppColors.darkBackground
    }
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    private func setViewControllerTitle(){
        self.title = viewModel?.getViewControllerTitle()
    }
    private func setupPolicyStatusViews(){
        policyStatusContainerView.backgroundColor = viewModel?.getPolicyContainerBackgroundColor()
        policyStatusLabel.attributedText = viewModel?.getPolicyStatusTitle()
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReceiptPriceTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableContainerView.backgroundColor = viewModel?.getTableViewBackgroundColor()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
    }
    
}
extension ReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getNumberOfSections() ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows(in: section) ?? 0
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
        guard let cellData = viewModel?.getCellData(indexPath: indexPath)
        else {
            return UITableViewCell()
        }
        let receiptCell: ReceiptPriceTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        receiptCell.setupCell(cellData: cellData)
        cell = receiptCell
        return cell
    }
}
