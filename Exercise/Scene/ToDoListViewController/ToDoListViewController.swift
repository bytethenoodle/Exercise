//
//  ToDoListViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class ToDoListViewController: BaseViewController<ToDoListViewModel, ToDoListCoordinator> {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationButtonToDoItemAdd: UIBarButtonItem?
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewController()
    }
    
    // MARK: - Setups
    
    private func setupViewController() {
        DispatchQueue.main.async {
            self.setupCellWhenSwipeTapped()
            self.setupForAddAction()
            self.populate()
        }
    }
    
    private func setupCellWhenSwipeTapped() {
        tableView.rx.setDelegate(self)
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
        self.showAlertWithField(title: "Add Item",
                                 message: "Adds a new item to the list. Setting the field empty or just spaces invalidates the process and does nothing.",
                                 buttonActionTitle: "Add",
                                 action: { [weak self] (fieldString) in
                                    self?.viewModel?.add(title: fieldString)
                                 })
    }
    
    func showEditAlert(indexPath: IndexPath) {
        self.showAlertWithField(title: "Edit Item",
                                 message: "Edits the title of the selected item. Setting the field empty or just spaces invalidates the process and does nothing.",
                                 buttonActionTitle: "Save",
                                 fieldText: viewModel?.fetchTitle(index: indexPath.row),
                                 action: { [weak self] (fieldString) in
                                    self?.viewModel?.edit(index: indexPath.row, title: fieldString)
                                 })
    }
    
    // MARK: - Table Refresh
    
    private func populate() {
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
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.viewModel?.toggle(index: indexPath.row)
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
