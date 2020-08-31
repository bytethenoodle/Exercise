//
//  ToDoListViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ToDoListViewController: BaseViewController<ToDoListViewModel, ToDoListCoordinator> {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var navigationButtonToDoItemAdd: UIBarButtonItem?
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewController()
    }
    
    // MARK: - Setups
    
    private func setupViewController() {
        DispatchQueue.main.async { [weak self] in
            self?.setupCellWhenSwipeTapped()
            self?.setupForAddAction()
            self?.populate()
        }
    }
    
    private func setupCellWhenSwipeTapped() {
        tableView?.rx.setDelegate(self)
                    .disposed(by: disposeBag)
    }
    
    func setupForAddAction() {
        navigationButtonToDoItemAdd?.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    self?.showAddAlert()
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - Alert Actions
    
    func showAddAlert() {
        
        // Declare elements for alert
        
        var inputTextField: UITextField?
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            self?.viewModel?.add(title: inputTextField?.text)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Setup and show alert
        
        showAlertWithTextField(title: "Add Item",
                               message: "Adds a new item to the list.",
                               actions: [addAction,
                                         cancelAction]) { (textField) in
            textField.placeholder = "Title"
            textField.text = String.empty
            inputTextField = textField
        }
        
        // Observe changes in text input
        inputTextField?.rx.text
        .bind {
            addAction.isEnabled =  !($0?.isEmpty ?? true)
        }
        .disposed(by: disposeBag)
    }
    
    func showEditAlert(indexPath: IndexPath) {
        
        // Declare elements for alert
        
        var inputTextField: UITextField?
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            self?.viewModel?.edit(index: indexPath.row, title: inputTextField?.text)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Setup and show alert
        
        showAlertWithTextField(title: "Edit Item",
                               message: "Edits the title of the selected item.",
                               actions: [saveAction,
                                         cancelAction]) { [weak self] (textField) in
            textField.placeholder = "Title"
            textField.text = self?.viewModel?.fetchTitle(index: indexPath.row)
            inputTextField = textField
        }
        
        // Observe changes in text input
        inputTextField?.rx.text
        .bind {
            saveAction.isEnabled =  !($0?.isEmpty ?? true)
        }
        .disposed(by: disposeBag)
    }
    
    // MARK: - Table Refresh
    
    private func populate() {
        guard let tableView = tableView else {return}
        let observableToDoItems = viewModel?.get().asObservable()
        let subscription = observableToDoItems?
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: ToDoListItemCell.self),
            cellType: ToDoListItemCell.self)) { (row, toDoItem, cell) in
            cell.setup(toDoItem: toDoItem)
        }
        subscription?.disposed(by: disposeBag)
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel?.toggle(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
                self?.viewModel?.remove(index: indexPath.row)
                return
            }

        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] (action, indexPath) in
                self?.showEditAlert(indexPath: indexPath)
                return
            }
            return [deleteButton, editButton]
        }
}
