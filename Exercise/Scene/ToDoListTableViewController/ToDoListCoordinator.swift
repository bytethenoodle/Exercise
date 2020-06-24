//
//  ToDoListCoordinator.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation

class ToDoListCoordinator: BaseSceneCoordinator {
    
    override func start() {
        super.start()
        let vc = ToDoListTableViewController.fromStoryboard()
        vc?.coordinator = self
        window?.rootViewController = vc
    }
}
