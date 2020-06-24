//
//  AppRouter.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

/// Class that handles the routing of pages within the app
open class AppRouter {
    
    // MARK: - Variables
    
    static let window = UIApplication.shared.keyWindow
    
    // MARK: - Enums
    
    /// Flow routes of the app
    public enum Route {
        /// The Home page of the app
        case home
    }
    
    // MARK: - Initializations
    
    // (uncomment if needed)
    // Singleton implementation
    // static let shared = ApplicationRouter()
    
    // (uncomment if needed)
    // Private implementation of init due to singleton implementation
    // private init() {}
    
    // MARK: - Private Static Methods
    
    private static func set(route: AppRouter.Route) {
        switch route {
            case .home:
                ToDoListCoordinator(window: window).start()
                break
        }
    }
    
    // MARK: - Open Static Methods
    
    /// Routes to the specified screen / page.
    /// Use this method when calling from the AppDelegate
    /// - Parameters:
    ///   - route: The specified screen to show as active
    ///
    public static func route(_ route: AppRouter.Route) {
        set(route: route)
    }
}
