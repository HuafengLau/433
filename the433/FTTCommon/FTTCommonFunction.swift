//
//  FTTCommonFunction.swift
//  the433
//
//  Created by tuan800 on 15/11/20.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
public func FTTColorRedColor() -> UIColor{
    return UIColor.colorFromRGB(0xf24141)
}

public func FTTColorGreenColor() -> UIColor{
    return UIColor.colorFromRGB(0x51be5b)
}

public func FTTColorBlueColor() -> UIColor{
    return UIColor.colorFromRGB(0x68b5f4)
}

public class FTTCommonFunction: NSObject {
    
    
    public class func isSameDay(date1 : NSDate,date2 : NSDate) -> Bool{
        let calender : NSCalendar = NSCalendar.currentCalendar()
        return calender.isDate(date1, inSameDayAsDate: date2)
    }
}

