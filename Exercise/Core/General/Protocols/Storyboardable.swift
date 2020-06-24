//
//  Storyboardable.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

public protocol Storyboardable where Self : UIViewController {}

public extension Storyboardable {
    static func fromStoryboard() -> Self? {
        let classString = String(describing: Self.self)
        let storyboard = UIStoryboard(name: classString, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: classString) as? Self
    }
}
