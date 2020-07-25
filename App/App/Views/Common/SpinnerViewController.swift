//
//  SpinnerViewController.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//


import UIKit

enum ViewType {
    case view
    case button
}

class DataLoaderSpinner {
    var vSpinner: UIView?
    var type: ViewType = .view
    
    static let shared = DataLoaderSpinner()
    func showSpinner(onView: UIView) {
        let spinnerView = UIView(frame: onView.bounds)
        let spinnerBackground = UIView()
        
        let value: CGPoint
        let style: UIActivityIndicatorView.Style
        let isBackgroundNeeded: Bool
        switch type {
        case .view:
            value = spinnerView.center
            style = .whiteLarge
            isBackgroundNeeded = true
            
        case .button:
            value = CGPoint(x: 40, y: 20)
            style = .white
            isBackgroundNeeded = false
        }
        
        spinnerBackground.frame = CGRect(x: onView.bounds.width / 2 - 40, y: onView.bounds.height / 2 - 40, width: 80, height: 80)
        
        spinnerBackground.layer.cornerRadius = 10
        spinnerBackground.backgroundColor = .lightGray
        
       // spinnerView.tintColor = AppColors.spinner.color
        
        let ai = UIActivityIndicatorView(style: style)
       // ai.color = AppColors.activityIndicator.color
        ai.startAnimating()
        ai.center = value
        spinnerBackground.center = spinnerView.center
        
        DispatchQueue.main.async {
            onView.addSubview(spinnerView)
            if isBackgroundNeeded {
                spinnerView.addSubview(spinnerBackground)
            }
            spinnerView.addSubview(ai)
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
