//
//  Employee.swift
//  bmhTimeSheet
//
//  Created by WilliamCastellano on 1/12/18.
//  Copyright © 2018 WCTech. All rights reserved.
//

import Foundation
import RealmSwift

class Employee: Object {
  @objc dynamic var name = ""
  @objc dynamic var phoneNumber = ""
  @objc dynamic var pinNumber = ""
  @objc dynamic var clockedIn = false
  let timeEntries = List<TimeEntry>()
}
