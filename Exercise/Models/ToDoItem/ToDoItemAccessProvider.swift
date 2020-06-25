//
//  ToDoItemAccessProvider.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import CoreData
import RxSwift
import RxCocoa

class ToDoItemAccessProvider {
    
    // MARK: - Properties
    
    private var toDoItemCoreData = BehaviorRelay<[ToDoItem]>(value: [])
    private var managedObjectContext : NSManagedObjectContext
    
    // MARK: - Initialization
    
    init() {
        toDoItemCoreData.accept([ToDoItem]())
        managedObjectContext = CoreDataUtility.persistentContainer.viewContext
        toDoItemCoreData.accept(fetch())
    }
    
    // MARK: - Fetching
    
    private func fetch() -> [ToDoItem] {
        let toDoItemFetchRequest = ToDoItem.fetch()
        toDoItemFetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(toDoItemFetchRequest)
        } catch {
            return []
        }
    }
    
    public func fetchObservable() -> Observable<[ToDoItem]> {
        toDoItemCoreData.accept(fetch())
        return toDoItemCoreData.asObservable()
    }
    
    // MARK: - Operations
    
    public func add(title: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: managedObjectContext) as! ToDoItem
        
        newTodo.title = title
        newTodo.isCompleted = false
        
        do {
            try managedObjectContext.save()
            toDoItemCoreData.accept(fetch())
        } catch {
            fatalError("error saving data")
        }
    }
    
    public func toggle(index: Int) {
        toDoItemCoreData.value[index].isCompleted = !toDoItemCoreData.value[index].isCompleted
        
        do {
            try managedObjectContext.save()
            toDoItemCoreData.accept(fetch())
        } catch {
            fatalError("error change data")
        }

    }
    
    public func remove(index: Int) {
        managedObjectContext.delete(toDoItemCoreData.value[index])
        
        do {
            try managedObjectContext.save()
            toDoItemCoreData.accept(fetch())
        } catch {
            fatalError("error delete data")
        }
    }
    
}
