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
    
    public func fetchTitle(index: Int) -> String? {
        let toDoItem = toDoItemCoreData.value[safeIndex: index]
        return toDoItem?.title
    }
    
    public func add(title: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: managedObjectContext) as! ToDoItem
        
        newTodo.title = title
        newTodo.isCompleted = false
        
        try? managedObjectContext.save()
        toDoItemCoreData.accept(fetch())
    }
    
    public func edit(index: Int, title: String) {
        let toDoItem = toDoItemCoreData.value[safeIndex: index]
        
        toDoItem?.title = title
        
        try? managedObjectContext.save()
        toDoItemCoreData.accept(fetch())
    }
    
    public func toggle(index: Int) {
        guard let toDoitem = toDoItemCoreData.value[safeIndex: index] else {return}
        toDoitem.isCompleted = !toDoitem.isCompleted
        
        try? managedObjectContext.save()
        toDoItemCoreData.accept(fetch())
    }
    
    public func remove(index: Int) {
        guard let toDoItem = toDoItemCoreData.value[safeIndex: index] else {return}
        managedObjectContext.delete(toDoItem)
        
        try? managedObjectContext.save()
        toDoItemCoreData.accept(fetch())
    }
    
}
