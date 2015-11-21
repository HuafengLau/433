//
//  FTTCommonFunction.swift
//  the433
//
//  Created by tuan800 on 15/11/20.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTCommonFunction: NSObject {
    
    
    public class func isSameDay(date1 : NSDate,date2 : NSDate) -> Bool{
        let calender : NSCalendar = NSCalendar.currentCalendar()
        return calender.isDate(date1, inSameDayAsDate: date2)
    }
}
