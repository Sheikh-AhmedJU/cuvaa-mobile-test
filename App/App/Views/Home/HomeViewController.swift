//
//  HomeViewController.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    // MARK:- IBOutlets
    // IBOOutlets for the ViewController
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var motorButton: ButtonWithImage!
    @IBOutlet weak var travelButton: ButtonWithImage!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Variable declarations
    private var viewModel: HomeViewModel?
    // MARK:- Setup Views
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        setupNavigationBar()
        setUpNavigationsButtons()
        setupBackGroundColor()
        setupTopButtonContainerView()
        loadPolicies()
        configureTableView()
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
    private func setupBackGroundColor(){
        view.backgroundColor = viewModel?.getBackgroundColor()
    }
    private func setUpNavigationsButtons(){
        let leftImage = viewModel?.getNavigationButton(buttonPosition: .left)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: nil, action: nil)
        let rightImage = viewModel?.getNavigationButton(buttonPosition: .right)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    private func setupTopButtonContainerView(){
        var title = viewModel?.getTransportButtonTitle(title: "Motor")
        var image = viewModel?.getImageforButton(asset: .motor)
        let backgroundColor = viewModel?.getTrasportButtonBackgroundColor()
        motorButton.setAttributedTitle(title, for: .normal)
        motorButton.setImage(image, for: .normal)
        motorButton.setBackgroundColor(color: backgroundColor)
        motorButton.addTarget(self, action: #selector(motorButtonPressed(sender:)), for: .touchDown)
        
        title = viewModel?.getTransportButtonTitle(title: "Travel", isAvailable: true )
        image = viewModel?.getImageforButton(asset: .aeroplane)
        travelButton.setAttributedTitle(title, for: .normal)
        travelButton.setImage(image, for: .normal)
        travelButton.setBackgroundColor(color: backgroundColor)
        travelButton.addTarget(self, action: #selector(travelButtonPressed), for: .touchDown)
        
    }
    @objc private func motorButtonPressed(sender: UIButton){
    }
    @objc private func travelButtonPressed(sender: UIButton){
    }
    // MARK:- load the policies
    private func loadPolicies(){
        toggleSpinnerView(shouldShow: true)
        viewModel?.fetchPolicies(completion: { [weak self] (result) in
            guard let `strongSelf` = self else {
                self?.toggleSpinnerView(shouldShow: false)
                return
            }
            switch result {
            case .success(_):
                strongSelf.reloadData()
                strongSelf.toggleSpinnerView(shouldShow: false)
                break
            case .failure(let error):
                strongSelf.toggleSpinnerView(shouldShow: false)
                print("Eror: \(error.localizedDescription)")
            }
        })
    }
    // MARK:- toggle the spinner view
    private func toggleSpinnerView(shouldShow: Bool) {
        let spinnerView = DataLoaderSpinner.shared
        DispatchQueue.main.async {
            switch shouldShow {
            case true:
                guard spinnerView.vSpinner == nil else { return}
                spinnerView.showSpinner(onView: self.view)
            case false:
                guard let _ = spinnerView.vSpinner else {return}
                spinnerView.removeSpinner()
            }
        }
    }
    // MARK:- configure the table view
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PolicyTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    // MARK:- reload data
    private func reloadData(){
        tableView.reloadData()
    }
}

// MARK:- Table View extensions
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let policyCell: PolicyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let cellData = viewModel?.getCellData(for: indexPath)
            else {
                print("Its for indexPath: \(indexPath)")
                return UITableViewCell()
        }
        policyCell.applyCellData(data: cellData)
        return policyCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: PolicyViewController = PolicyViewController.instantiate()
        let registrationPlate = viewModel?.getCellData(for: indexPath).first?.registrationPlate
        let models = viewModel?.getAllPolicies(for: registrationPlate) ?? []
        let policyViewModel = PolicyViewModel(policies: models)
        vc.viewModel = policyViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

