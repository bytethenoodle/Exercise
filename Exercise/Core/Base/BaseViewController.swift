//
//  BaseViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class BaseViewController<T: ViewModel>: UIViewController, Storyboardable, ViewModelable, SceneCoordinatable {
    lazy var viewModel: T? = T()
    lazy var coordinator: SceneCoordinator? = nil
}
