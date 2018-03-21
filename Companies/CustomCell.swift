//
//  CustomCell.swift
//  Companies
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 john. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    weak var delegate: OneCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}
