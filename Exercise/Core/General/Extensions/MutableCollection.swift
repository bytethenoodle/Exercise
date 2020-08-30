//
//  MutableCollection.swift
//  Exercise
//
//  Created by Elbert John Orozco on 2020/08/30.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation

extension MutableCollection {
    subscript(safeIndex index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
