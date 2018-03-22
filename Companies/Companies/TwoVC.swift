//
//  TwoVC.swift
//  Companies
//
//  Created by john bradley on 3/19/18.
//  Copyright © 2018 john. All rights reserved.
//

import UIKit
import CoreData

class TwoVC: UIViewController {
    weak var delegate: TwoVCDelegate?
    var edit: List?
    var item: [List]?
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var dateField: UIDatePicker!
    var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if edit != nil {
            titleField.text = edit?.title
            detailsField.text = edit?.detail
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addAction(_ sender: UIButton) {
        if edit != nil {
            if let destination = delegate {
                destination.catchData(oldItem: (edit)!)
            }
            
        }
            print("NEW")
            let item = NSEntityDescription.insertNewObject(forEntityName: "List", into:
                managedObjectContext ) as! List
            item.title = titleField.text
            item.detail = detailsField.text
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
            let date = dateFormatter.string(from: self.dateField.date)
            item.due_date = date
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
            if let destination = delegate {
                destination.refreshTable()
            }
            dismiss(animated: true, completion: nil)
        }
    }
