//
//  ToDoListItemCell.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

class ToDoListItemCell: BaseTableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    func setup(toDoItem: ToDoItem) {
        
        labelTitle?.text = toDoItem.title
        
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
