//
//  UIViewController.swift
//  Exercise
//
//  Created by Elbert John A. Orozco on 6/25/20.
//  Copyright © 2020 Elbert John A. Orozco. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTextField(title: String?,
                                message: String?,
                                actions: [UIAlertAction],
                                textFieldSetup: @escaping (_ textField: UITextField) -> Void) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        alert.title = title
        alert.message = message

        alert.addTextField { (textField) in
            textFieldSetup(textField)
        }
                
        for action in actions {
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
