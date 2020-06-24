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
    
    /// Returns the view controller from the defined route
    /// - Parameters:
    ///   - route: The defined route
    /// - Returns: The view controller from the defined route
    ///
    private static func viewController(route: AppRouter.Route) -> UIViewController? {
        switch route {
            case .home:
                return ToDoListTableViewController.fromStoryboard()
        }
    }
    
    private static func set(route: AppRouter.Route) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = viewController(route: route)
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
