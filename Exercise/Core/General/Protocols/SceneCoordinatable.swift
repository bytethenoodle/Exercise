//
//  SceneCoordinatable.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation

public protocol SceneCoordinatable {
    
    associatedtype SceneCoordinatorType: SceneCoordinator
    
    var coordinator: SceneCoordinatorType? {get set}
}
