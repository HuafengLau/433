//
//  FTTPersonalCommonItem.swift
//  the433
//
//  Created by 黄元庆 on 16/1/16.
//  Copyright © 2016年 tuan800. All rights reserved.
//

import UIKit
public enum The433PersonalItemTag : String{
    case NICKNAME
    case PHONE
}
class FTTPersonalCommonItem: NSObject{
    var title : String?
    var detail : String?
    var itemTag : The433PersonalItemTag?
}
