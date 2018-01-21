//
//  AdminViewController.swift
//  bmhTimeSheet
//
//  Created by WilliamCastellano on 1/15/18.
//  Copyright © 2018 WCTech. All rights reserved.
//

import UIKit
import RealmSwift
//import JTAppleCalendar

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var adminTableView: UITableView!

  
  let timeFormatter = DateFormatter()
  let dateFormatter = DateFormatter()
  
  var employeeArray: Results<Employee>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    adminTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return (employeeArray?.count)!
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return employeeArray?[section].name
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60.0
  }
  
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (employeeArray?[section].timeEntries.count)!
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = adminTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
    
    if let currentTimeEntry = employeeArray?[indexPath.section].timeEntries[indexPath.row] {
      cell.date.text = currentTimeEntry.date
      
      let clockInLabel = Date(timeIntervalSince1970: currentTimeEntry.clockIn)
      cell.signInTime.text = timeFormatter.string(from: clockInLabel)
      
      if currentTimeEntry.clockOut == 0 {
        cell.signOutTime.text = ""
      } else {
        let clockOutLabel = Date(timeIntervalSince1970: currentTimeEntry.clockOut)
        cell.signOutTime.text = timeFormatter.string(from: clockOutLabel)
      }
      
      cell.totalHours.text = currentTimeEntry.totalHours
    }
    
    return cell
  }
  
}

