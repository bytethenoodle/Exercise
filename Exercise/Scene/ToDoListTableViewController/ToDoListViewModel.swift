//
//  ToDoListViewModel.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ToDoListViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private var toDoItems = BehaviorRelay<[ToDoItem]>(value: [])
    private var toDoItemAccessProvider = ToDoItemAccessProvider()
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializations
    
    required init() {
        super.init()
        self.fetchToDoItemsAndUpdateObservableToDoItems()
    }
    
    // MARK: - Operations
    
    public func get() -> BehaviorRelay<[ToDoItem]> {
        return toDoItems
    }
    
    private func fetchToDoItemsAndUpdateObservableToDoItems() {
        toDoItemAccessProvider.fetchObservable()
            .map({ $0 })
            .subscribe(onNext : { [weak self] (toDoItems) in
                self?.toDoItems.accept(toDoItems)
            })
            .disposed(by: disposeBag)
    }
    
    public func add(title: String) {
        toDoItemAccessProvider.add(title: title)
    }
    
    public func toggle(index: Int) {
        toDoItemAccessProvider.toggle(index: index)
    }
    
    public func remove(index: Int) {
        toDoItemAccessProvider.remove(index: index)
    }
}
