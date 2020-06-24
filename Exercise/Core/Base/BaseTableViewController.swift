//
//  BaseTableViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class BaseTableViewController<T: ViewModel>: UITableViewController, Storyboardable, ViewModelable, SceneCoordinatable {
    lazy var viewModel: T? = T()
    lazy var coordinator: SceneCoordinator? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        }
        return .default
    }
}
