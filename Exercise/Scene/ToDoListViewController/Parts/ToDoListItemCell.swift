//
//  ToDoListItemCell.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import Foundation

class ToDoListItemCell: BaseTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAppearance()
    }
    
    func setup(toDoItem: ToDoItem) {
        
        textLabel?.text = toDoItem.title
        
        if toDoItem.isCompleted {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
    
    private func setupAppearance() {
        textLabel?.textColor = Color.textColor
    }
}
