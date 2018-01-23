//
//  ViewController.swift
//  bmhTimeSheet
//
//  Created by WilliamCastellano on 1/12/18.
//  Copyright © 2018 WCTech. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  let realm = try! Realm()
  
  var employeeArray: Results<Employee>?
  var timeEntries: Results<TimeEntry>?
  
  var currentTime: Double?
  var date: Date?
  var currentEmployee: Employee?
  
  let timeFormatter = DateFormatter()
  let dateFormatter = DateFormatter()
  
  @IBOutlet var tableview: UITableView!
  @IBOutlet var pinNumberTextField: UITextField!
  
  //MARK: - Clock In/Out Button
  
  @IBAction func clockInOutButton(_ sender: UIButton) {
    
    if pinNumberTextField.text! == "9999" {
      performSegue(withIdentifier: "goToAdmin", sender: self)
    }
    
    
    currentEmployee = employeeArray?.filter("pinNumber == %@", pinNumberTextField.text!).first
    timeEntries = currentEmployee?.timeEntries.sorted(byKeyPath: "clockIn", ascending: false)
    currentTime = Date().timeIntervalSince1970
    date = Date()
    
    if let employee = currentEmployee {
      if employee.clockedIn == false {
        clockIn(currentEmployee: employee)
        tableview.reloadData()
      } else if employee.clockedIn == true {
        clockOut(currentEmployee: employee)
        tableview.reloadData()
      } else {
        print("Error")
      }
      
      tableview.alpha = 1
      print(employee.timeEntries.last!)
    }
    
    
  }
  
  //MARK: - Clock In/Out Functions
  
  func clockIn(currentEmployee: Employee) {
    
    do {
      try realm.write {
        let newTimeEntry = TimeEntry()
        newTimeEntry.clockIn = currentTime!
        newTimeEntry.clockOut = 0
        newTimeEntry.date = dateFormatter.string(from: date!)
        currentEmployee.clockedIn = true
        currentEmployee.timeEntries.append(newTimeEntry)
      }
    } catch {
      print("Could not save new time entry: \(error)")
    }
  }
  
  func clockOut(currentEmployee: Employee) {
    if let timeEntry = currentEmployee.timeEntries.last {
      do {
        try realm.write {
          timeEntry.clockOut = currentTime!
          let hours = Double(((timeEntry.clockOut) - timeEntry.clockIn)/3600)
          timeEntry.totalHours = String(format: "%.2f", hours)
          currentEmployee.clockedIn = false
        }
      } catch {
        print("could not find the time entry")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableview.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    
    let numberOfEmployees = realm.objects(Employee.self).count
    if numberOfEmployees != 0 {
      employeeArray = realm.objects(Employee.self)
    }
    
//    addNewUsers()
    
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
  }
  
  func addNewUsers() {
    let user1 = Employee()
    let user2 = Employee()
    
    user1.name = "Arteen"
    user1.pinNumber = "1111"
    
    user2.name = "Will"
    user2.pinNumber = "0000"
    
    do {
      try realm.write {
        realm.add(user1)
        realm.add(user2)
      }
    } catch {
      print("Error")
    }
  }
  
}

//MARK: - Table View Methods

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (currentEmployee?.timeEntries.count) ?? 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
    
    if let currentTimeEntry = timeEntries?[indexPath.row] {
      cell.date.text = currentTimeEntry.date
      cell.employee.text = currentEmployee?.name
      
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! AdminViewController
    
    destinationVC.employeeArray = employeeArray
  }
}
