//
//  AppCoordinator.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

/// The AppCoordinator manages the overall lifecycle of the app.
/// The class is inherited by the AppDeleagate or SceneDelegate (if using >= iOS 13.0)
open class AppCoordinator: UIResponder {
    
    // MARK: - Properties
    
    /// The private property _window holds the actual instance of the UIWindow.
    @objc private var _window: UIWindow?
    
    /// The UIWindow property that holds the kew window
    /// Set for compatibility with devices older than iOS 13
    @objc open var window: UIWindow? {
        get {
            /// If private _window is nil, set a default UIWindow instance
            /// Then, return the new _window variable
            _window == nil ? {_window = UIWindow()}() : {}()
            return _window
        }
        set (window) {
            /// Set the value of  private _window
            _window = window
        }
    }
    
    // MARK: - Open Methods
    
    open func setKeyWindowAndStart() {
        window?.makeKeyAndVisible()
        start()
    }
    
    @available(iOS 13.0, *)
    open func setKeyWindowAndStart(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        start()
    }
    
    // MARK: - Protocol Methods
    
    open func start() {
        AppRouter.route(.home)
    }
}
