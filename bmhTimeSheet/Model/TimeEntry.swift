//
//  TimeEntry.swift
//  bmhTimeSheet
//
//  Created by WilliamCastellano on 1/12/18.
//  Copyright © 2018 WCTech. All rights reserved.
//

import Foundation
import RealmSwift

class TimeEntry: Object {
  @objc dynamic var date: String?
  @objc dynamic var clockIn = 0.0
  @objc dynamic var clockOut = 0.0
  @objc dynamic var totalHours = ""
  var parentEmployee = LinkingObjects(fromType: Employee.self, property: "timeEntries")
}
