//
//  ViewController.swift
//  Companies
//
//  Created by john bradley on 3/19/18.
//  Copyright © 2018 john. All rights reserved.
//

import UIKit

class OneVC: UIViewController {

    @IBAction func addAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueOne", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension OneVC: UIViewController

