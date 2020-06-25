//
//  UIViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithField(title: String,
                            message: String,
                            buttonActionTitle: String,
                            fieldText: String? = String(),
                            action: @escaping (_ string: String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.text = fieldText
        }
        alert.addAction(UIAlertAction(title: buttonActionTitle, style: .default, handler: { al in
            let fieldString = alert.textFields?.first?.text
            action(fieldString)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
