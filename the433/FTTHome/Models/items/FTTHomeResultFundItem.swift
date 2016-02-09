//
//  FTTHomeResultFundItem.swift
//  the433
//
//  Created by 黄元庆 on 15/12/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeResultFundItem: NSObject {
    var type : The433RiskLevel?//风险类型高中低
    var kindType : The433AllType?//资产类型股票基金 指数基金==
    var name : NSString?//名字
    var code : NSString?//基金代码
    var latestPrice : NSString?//最新单笔价格
    var allAssets : NSString?//该项总资产
    var allEarn : NSString?//该项总收入
    var allCount : NSString?//该项持有总份额
    var latestEarn : NSString?//该项最新收益
    var latestEarnPercent : NSString?//该项最新收益率
    var latestDate : NSString?//该项最新日期
}
