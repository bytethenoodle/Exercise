//
//  ToDoItemAccessProvider.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import CoreData
import RxSwift

class ToDoItemAccessProvider {
    
    private var toDoCoreData = Variable<[TodoItem]>([])
    private var managedObjectContext : NSManagedObjectContext
    
    init() {
        toDoCoreData.value = [TodoItem]()
        managedObjectContext = delegate.persistentContainer.viewContext
        
        todosFromCoreData.value = fetchData()
    }
    
    // MARK: - fetching Todos from Core Data and update observable todos
    private func fetchData() -> [Todo] {
        let todoFetchRequest = Todo.todoFetchRequest()
        todoFetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(todoFetchRequest)
        } catch {
            return []
        }
        
    }
    
    // MARK: - return observable todo
    public func fetchObservableData() -> Observable<[Todo]> {
        todosFromCoreData.value = fetchData()
        return todosFromCoreData.asObservable()
    }
    
    // MARK: - add new todo from Core Data
    public func addTodo(withTodo todo: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: managedObjectContext) as! Todo
        
        newTodo.todo = todo
        newTodo.isCompleted = false
        
        do {
            try managedObjectContext.save()
            todosFromCoreData.value = fetchData()
        } catch {
            fatalError("error saving data")
        }
    }
    
    // MARK: - toggle selected todo's isCompleted value
    public func toggleTodoIsCompleted(withIndex index: Int) {
        todosFromCoreData.value[index].isCompleted = !todosFromCoreData.value[index].isCompleted
        
        do {
            try managedObjectContext.save()
            todosFromCoreData.value = fetchData()
        } catch {
            fatalError("error change data")
        }

    }
    
    // MARK: - remove specified todo from Core Data
    public func removeTodo(withIndex index: Int) {
        managedObjectContext.delete(todosFromCoreData.value[index])
        
        do {
            try managedObjectContext.save()
            todosFromCoreData.value = fetchData()
        } catch {
            fatalError("error delete data")
        }
    }
    
}
