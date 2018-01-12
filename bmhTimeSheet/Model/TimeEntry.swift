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
  @objc dynamic var date: Date?
  @objc dynamic var clockIn: Date?
  @objc dynamic var clockOut: Date?
  @objc dynamic var totalHours = 0
  var parentEmployee = LinkingObjects(fromType: Employee.self, property: "timeEntries")
}
