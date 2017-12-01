//
//  CalendarUtil.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 29..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import EventKit

class CalendarUtil {
  
  class func addEventToCalendar(title: String, description: String?,
                                date : Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    let eventStore = EKEventStore()
    
    eventStore.requestAccess(to: .event, completion: { (granted, error) in
      if (granted) && (error == nil) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = date
        event.endDate = date
        event.notes = description
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
          try eventStore.save(event, span: .thisEvent)
        } catch let e as NSError {
          completion?(false, e)
          return
        }
        completion?(true, nil)
      } else {
        completion?(false, error as NSError?)
      }
    })
  }
  
}
