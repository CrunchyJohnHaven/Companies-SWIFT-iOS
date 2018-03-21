//
//  ViewController.swift
//  Companies
//
//  Created by john bradley on 3/19/18.
//  Copyright © 2018 john. All rights reserved.
//

import UIKit
protocol OneCellDelegate: class {
}

class OneVC: UIViewController {
    var companies: [String] = ["Company One"]

    @IBAction func addAction(_ sender: UIButton) {
        print("addAction")
        performSegue(withIdentifier: "OneSegue", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension OneVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneCell", for: indexPath) as! CustomCell
        cell.titleLabel.text = companies[indexPath.row]
        cell.detailLabel.text = companies[indexPath.row]
        print("CELL: ", cell)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rowsInSection")
        print("companies.count: ", companies.count)
        return companies.count
    }
}
extension OneVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow( at: indexPath, animated: true )
    }
}
extension OneVC: OneCellDelegate {
}
