//
//  FTTHomeShowAllTypeModel.swift
//  the433
//
//  Created by 黄元庆 on 15/11/30.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeShowAllTypeModel: FTTBaseModel {
    override init() {
        super.init()
    }
    override func loadItems() {
        let item1 : FTTBubbleItem  = FTTBubbleItem()
        item1.title = "债基"
        item1.longTitle = "债券基金"
        item1.typeDescription = "中风险。将大部分资金投资债券的基金，涨跌幅度小于股票基金，盈亏相对稳定。"
        item1.color = UIColor.orangeColor()
        item1.riskLevel = The433RiskLevel.MID
        item1.theType = The433AllType.债券型
        self.items?.addObject(item1)
        
        let item2 : FTTBubbleItem  = FTTBubbleItem()
        item2.title = "银行"
        item2.longTitle = "银行存款"
        item2.typeDescription = "既不是最安全的，也不是收益最高的，更不是服务最好的投资品。"
        item2.color = FTTColorBlueColor()
        item2.riskLevel = The433RiskLevel.LOW
        item2.theType = The433AllType.银行
        self.items?.addObject(item2)
        
        let item3 : FTTBubbleItem  = FTTBubbleItem()
        item3.title = "股基"
        item3.longTitle = "股票基金"
        item3.typeDescription = "高风险。将大部分资金投资股票的基金，如果期望获得股票的收益，又不想花时间选择股票，那么股票基金是不错的选择。选择股票基金要充分考虑基金过往的业绩，晨星基金网有不错的筛选工具。"
        item3.color = UIColor.redColor()
        item3.riskLevel = The433RiskLevel.HIGHT
        item3.theType = The433AllType.股票型
        self.items?.addObject(item3)
        
        
        let item4 : FTTBubbleItem  = FTTBubbleItem()
        item4.title = "混基"
        item4.longTitle = "混合基金"
        item4.typeDescription = "高风险。同时投资于股票、债券，没有明确的投资方向的基金。风险低于股票基金，预期收益则高于债券基金。"
        item4.color = UIColor.redColor()
        item4.riskLevel = The433RiskLevel.HIGHT
        item4.theType = The433AllType.混合型
        self.items?.addObject(item4)
        
        let item5 : FTTBubbleItem  = FTTBubbleItem()
        item5.title = "p2p"
        item5.longTitle = "p2p"
        item5.typeDescription = "p2p行业已经进入淘汰整合期，国内比较知名的平台有人人贷、陆金所等等。收益一般在4%~10%，监管法律不健全，切勿迷恋过高收益的平台。"
        item5.color = UIColor.orangeColor()
        item5.riskLevel = The433RiskLevel.MID
        item5.theType = The433AllType.p2p
        self.items?.addObject(item5)
        
        let item6 : FTTBubbleItem  = FTTBubbleItem()
        item6.title = "现金"
        item6.longTitle = "现金"
        item6.typeDescription = "无需太多，也不能没有，应急所需。"
        item6.color = FTTColorBlueColor()
        item6.riskLevel = The433RiskLevel.LOW
        item6.theType = The433AllType.现金
        self.items?.addObject(item6)
        
        
        
        let item7 : FTTBubbleItem  = FTTBubbleItem()
        item7.title = "股市"
        item7.longTitle = "股市"
        item7.typeDescription = "高风险！高风险！高风险！股市有风险，入市需谨慎，吴晓波说，中国的股市像赌场。"
        item7.color = UIColor.redColor()
        item7.riskLevel = The433RiskLevel.HIGHT
        item7.theType = The433AllType.股票
        self.items?.addObject(item7)
        
        let item8 : FTTBubbleItem  = FTTBubbleItem()
        item8.title = "指基"
        item8.longTitle = "指数基金"
        item8.typeDescription = "高风险。是一种比较省心的投资方式，能够获得股市的平均回报。指数基金的买入时机并不太重要，越早买越好，一般经过一个完整的经济周期（大概6到8年）就会有明显回报。"
        item8.color = UIColor.redColor()
        item8.riskLevel = The433RiskLevel.HIGHT
        item8.theType = The433AllType.指数型
        self.items?.addObject(item8)
        
        let item9 : FTTBubbleItem  = FTTBubbleItem()
        item9.title = "宝宝"
        item9.longTitle = "宝宝类"
        item9.typeDescription = "宝宝类的理财产品，以余额宝为代表，收益在3％到5%左右。收益稳定，取现灵活，是银行活期存款的绝佳替代品。"
        item9.color = FTTColorBlueColor()
        item9.riskLevel = The433RiskLevel.LOW
        item9.theType = The433AllType.余额宝
        self.items?.addObject(item9)
        
        
    }
}
