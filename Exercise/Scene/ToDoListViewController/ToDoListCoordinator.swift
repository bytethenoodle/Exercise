//
//  ToDoListCoordinator.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation

class ToDoListCoordinator: BaseSceneCoordinator {
    
    let navigationController = BaseNavigationController()
    
    override func start() {
        super.start()
        
        guard let vc = ToDoListViewController.fromStoryboard() else {return}
        vc.coordinator = self
        
        navigationController.setViewControllers([vc], animated: false)
        window?.rootViewController = navigationController
    }
}
