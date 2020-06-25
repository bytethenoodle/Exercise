//
//  ToDoItem+CoreDataProperties.swift
//  
//
//  Created by Elbert John A. Orozco on 6/25/20.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?

}
