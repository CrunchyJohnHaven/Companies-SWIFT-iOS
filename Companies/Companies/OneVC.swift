//
//  ViewController.swift
//  Companies
//
//  Created by john bradley on 3/19/18.
//  Copyright © 2018 john. All rights reserved.
//

import UIKit
import CoreData
protocol OneCellDelegate: class {
}
protocol TwoVCDelegate: class {
    func refreshTable()
}
class OneVC: UIViewController {
    var listItem = [List]()
    var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    @IBAction func addAction(_ sender: UIButton) {
        print("addAction")
        performSegue(withIdentifier: "OneSegue", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? TwoVC
        destination?.delegate = self
    }
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>( entityName:"List")
        do {
            listItem = try managedObjectContext.fetch(request) as! [List]
        } catch {
            print(error)
        }
    }
}
extension OneVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneCell", for: indexPath) as! CustomCell
        cell.titleLabel.text = listItem[indexPath.row].title
        cell.detailLabel.text = listItem[indexPath.row].detail
        cell.dueDate.text = listItem[indexPath.row].due_date
        print("CELL: ", cell)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rowsInSection")
        print("companies.count: ", listItem.count)
        return listItem.count
    }
}
extension OneVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow( at: indexPath, animated: true )
    }
}
extension OneVC: OneCellDelegate {
}
extension OneVC: TwoVCDelegate {
    func refreshTable() {
        fetchAllItems()
        tableView.reloadData()
    }
}
