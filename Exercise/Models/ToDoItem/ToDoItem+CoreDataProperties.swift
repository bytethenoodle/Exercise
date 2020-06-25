//
//  ToDoItem+CoreDataProperties.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//
//

import Foundation
import CoreData

extension ToDoItem {

    @nonobjc public class func fetch() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?

}
