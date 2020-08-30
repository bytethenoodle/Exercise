//
//  Collection.swift
//  Exercise
//
//  Created by Elbert John Orozco on 2020/08/30.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safeIndex index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
