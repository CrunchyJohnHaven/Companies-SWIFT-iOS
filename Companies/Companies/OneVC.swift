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
    func catchData(oldItem: List)
}
class OneVC: UIViewController {
    var listItem = [List]()
    var thisRow: List?
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
//        print("PREPARE FOR SEGUE")
        if let indexRow = sender as? Int {
            self.thisRow = listItem[indexRow]
            let destination = segue.destination as? TwoVC
            destination?.delegate = self
            destination?.edit = self.thisRow
        }
        let destination = segue.destination as? TwoVC
        destination?.delegate = self
    }
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>( entityName:"List")
        do {
            listItem = try managedObjectContext.fetch(request) as! [List]
            print("LISTITEM: ", listItem)
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
        if cell.accessoryType == .detailButton {
            cell.accessoryType = .none
        }
        else {
            cell.accessoryType = .detailButton
        }
        cell.delegate = self
        print("CELL: ", cell)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = listItem[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        listItem.remove(at: indexPath.row)
        tableView.reloadData()
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rowsInSection")
        print("companies.count: ", listItem.count)
        return listItem.count
    }
}
extension OneVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DIDSELECTROWAT: ", listItem[indexPath.row].bool)
        tableView.deselectRow( at: indexPath, animated: true )
            if let cell = tableView.cellForRow( at: indexPath) {
                if listItem[indexPath.row].bool == true {
                    print(".detailbutton")
                    listItem[indexPath.row].bool = false
                    cell.accessoryType = .none
                }
                else {
                    if let cell = tableView.cellForRow( at: indexPath) {
                        if listItem[indexPath.row].bool == false {
                            print(".none")
                            listItem[indexPath.row].bool = true
                            cell.accessoryType = .detailButton
                        }
                    }
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print( error )
                    }
                }
            }
        }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        print("INDEXPATH:", indexPath.row)
        performSegue(withIdentifier: "OneSegue", sender: indexPath.row)
    }
}
extension OneVC: OneCellDelegate {
}
extension OneVC: TwoVCDelegate {
    func catchData(oldItem: List) {
        managedObjectContext.delete(oldItem)
        tableView.reloadData()
        
    }
    
    func refreshTable() {
        fetchAllItems()
        tableView.reloadData()
    }

}
