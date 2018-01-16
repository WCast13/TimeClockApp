//
//  CustomTableViewCell.swift
//  bmhTimeSheet
//
//  Created by WilliamCastellano on 1/14/18.
//  Copyright © 2018 WCTech. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  @IBOutlet var date: UILabel!
  @IBOutlet var employee: UILabel!
  @IBOutlet var signInTime: UILabel!
  @IBOutlet var signOutTime: UILabel!
  @IBOutlet var totalHours: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
}
    

