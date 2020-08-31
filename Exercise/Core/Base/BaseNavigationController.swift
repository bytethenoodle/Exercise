//
//  BaseNavigationController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    private func setAppearance() {
        navigationBar.barTintColor = Color.backgroundColor
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.textColor as Any]
    }
}
