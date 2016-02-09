//
//  FTTBubbleItem.swift
//  the433
//
//  Created by tuan800 on 15/11/30.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
public enum The433RiskLevel : NSString{
    case HIGHT
    case MID
    case LOW
}

public enum The433AllType : NSString{
    case 债券型
    case 指数型
    case 股票型
    case 混合型
    case 银行
    case 现金
    case p2p
    case 股票
    case 余额宝
}
class FTTBubbleItem: NSObject {
    var title : NSString?
    var longTitle : NSString?
    var typeDescription : NSString?
    var color : UIColor?
    var riskLevel : The433RiskLevel?
    var theType : The433AllType?
}
