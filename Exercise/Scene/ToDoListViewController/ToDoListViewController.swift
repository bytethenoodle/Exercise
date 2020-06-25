//
//  ToDoListViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class ToDoListViewController: BaseViewController<ToDoListViewModel, ToDoListCoordinator> {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationButtonToDoItemAdd: UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.setupViewController()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - perform a binding from observableTodo from ViewModel to todoListTableView
    
    private func setupViewController() {
        DispatchQueue.main.async {
            self.populateTodoListTableView()
            self.setupTodoListTableViewCellWhenTapped()
            self.setupTodoListTableViewCellWhenDeleted()
            self.setupActionWhenButtonAddTodoTapped()
        }
    }
    
    private func populateTodoListTableView() {
        
        let observableToDoItems = viewModel?.get().asObservable()
        let subscription = observableToDoItems?.bind(to: tableView.rx.items(cellIdentifier: String(describing: ToDoListItemCell.self),
                                                         cellType: ToDoListItemCell.self)) { (row, toDoItem, cell) in
            cell.setup(toDoItem: toDoItem)
        }
        subscription?.disposed(by: disposeBag)
        
        
    }
    
    private func setupTodoListTableViewCellWhenTapped() {
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.tableView.deselectRow(at: indexPath, animated: false)
                self.viewModel?.toggle(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTodoListTableViewCellWhenDeleted() {
        tableView.rx.itemDeleted
            .subscribe(onNext : { indexPath in
                self.viewModel?.remove(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - event handling when add button tapped, and add todo to persistent storage via viewmodel
    func setupActionWhenButtonAddTodoTapped() {
        navigationButtonToDoItemAdd?.rx.tap
            .subscribe(
                onNext: {
                    let addTodoAlert = UIAlertController(title: "Add Todo", message: "Enter your string", preferredStyle: .alert)
                    
                    addTodoAlert.addTextField(configurationHandler: nil)
                    addTodoAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { al in
                        let todoString = addTodoAlert.textFields![0].text
                        if !(todoString!.isEmpty) {
                            self.viewModel?.add(title: todoString ?? String())
                        }
                    }))
                    
                    addTodoAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    
                    self.present(addTodoAlert, animated: true, completion: nil)
                }
            )
            .disposed(by: disposeBag)
    }


}

