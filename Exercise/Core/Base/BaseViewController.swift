//
//  BaseViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class BaseViewController<VT: ViewModel, CT: SceneCoordinator>: UIViewController, Storyboardable, ViewModelable, SceneCoordinatable {
        
    lazy var viewModel: VT? = VT()
    lazy var coordinator: CT? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }
}
