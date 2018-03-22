//
//  HideKeyboardEctension.swift
//
//  Created by john bradley on 3/17/18.
//  Copyright © 2018 john. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:
            #selector( UIViewController.dismissKeyboard ) )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer( tap )
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

