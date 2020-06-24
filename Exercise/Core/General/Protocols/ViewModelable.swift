//
//  ViewModelable.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

protocol ViewModelable where Self: UIViewController {
    
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType? {get set}
}
