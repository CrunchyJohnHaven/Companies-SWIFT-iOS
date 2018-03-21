//
//  TwoVC.swift
//  Companies
//
//  Created by john bradley on 3/19/18.
//  Copyright © 2018 john. All rights reserved.
//

import UIKit

class TwoVC: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var dateField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
