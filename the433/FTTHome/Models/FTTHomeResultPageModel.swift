//
//  FTTHomeResultPageModel.swift
//  the433
//
//  Created by 黄元庆 on 15/12/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeResultPageModel: FTTBaseModel {
    var service : FTTHomeResultService?
    
    var hightArray : NSMutableArray?
    var midArray : NSMutableArray?
    var lowArray : NSMutableArray?
    override init() {
        super.init()
        self.service = FTTHomeResultService()
        //let tipsItem : FTTHomeResultAddTipsItem = FTTHomeResultAddTipsItem()
        hightArray = NSMutableArray()
        //hightArray?.addObject(tipsItem)
        /*
        let fundItem = FTTHomeResultFundItem()
        fundItem.type = The433RiskLevel.HIGHT
        fundItem.kindType = The433AllType.GOOD
        fundItem.name = "买我就跌成狗股票基金"
        fundItem.code = "995995"
        fundItem.allAssets = "3344.55"
        fundItem.allEarn = "+234.56"
        fundItem.latestEarn = "-99.99"
        fundItem.latestEarnPercent = "-5.97%"
        fundItem.latestDate = "2015-12-18"
        fundItem.allCount = "223344.55"
        fundItem.latestPrice = "3.009"
        hightArray?.addObject(fundItem)
        */
        midArray = NSMutableArray()
        /*
        let fundItem1 = FTTHomeResultFundItem()
        fundItem1.type = The433RiskLevel.MID
        fundItem1.kindType = The433AllType.SAD
        fundItem1.name = "买我绝逼跌成狗股票基金"
        fundItem1.code = "995995"
        fundItem1.allAssets = "2266.55"
        fundItem1.allEarn = "-47.56"
        fundItem1.latestEarn = "+8.99"
        fundItem1.latestEarnPercent = "+7.97%"
        fundItem1.latestDate = "2015-12-19"
        fundItem1.allCount = "223344.55"
        fundItem1.latestPrice = "3.009"
        midArray?.addObject(fundItem1)
        */
        lowArray = NSMutableArray()
        //lowArray?.addObject(tipsItem)
        self.items?.addObject(hightArray!)
        self.items?.addObject(midArray!)
        self.items?.addObject(lowArray!)
    }
    
    ///获取主资产信息请求
    func sendAllAssetsRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.getAllAssets(params: paramsDict, completion: {
                [weak self]
                (retDict : NSDictionary)in
                if let instance = self{
                    let item = instance.wrapperAllAssetsItem(retDict)
                    completion(["item" : item])
                }
                }, failed: {
                (faileDict : NSDictionary)in
                failed(faileDict)
            })
    }
    
    ///封装主资产信息
    func wrapperAllAssetsItem(retDitc : NSDictionary) -> FTTHomeResultHeaderItem{
        let item : FTTHomeResultHeaderItem = FTTHomeResultHeaderItem()
        let dict = retDitc.objectForKey("data") as? NSDictionary
        if let allAssets = dict?.objectForKey("totalProperty") as? NSString{
            item.allAssets = allAssets.float_2f
        }else{
            item.allAssets = "0.00"
        }
        
        if let allEarn = dict?.objectForKey("totalProfit") as? NSString{
            item.allEarn = allEarn.float_2f
        }else{
            item.allEarn = "0.00"
        }
        
        if let yesterdayEarn = dict?.objectForKey("profit") as? NSString{
            item.yesterdayEarn = yesterdayEarn.float_2f
        }else{
            item.yesterdayEarn = "0.00"
        }
        
        if let refreshDay = dict?.objectForKey("dayString"){
            item.refreshDay = refreshDay as? NSString
        }else{
            item.refreshDay = ""
        }
        
        if let hightPrecent = dict?.objectForKey("highPercent"){
            item.hightPrecent = hightPrecent as? NSString
        }else{
            item.hightPrecent = "0.00"
        }
        
        if let midPrecent = dict?.objectForKey("middlePercent"){
            item.midPrecent = midPrecent as? NSString
        }else{
            item.midPrecent = "0.00"
        }
        
        if let lowPrecent = dict?.objectForKey("lowPercent"){
            item.lowPrecent = lowPrecent as? NSString
        }else{
            item.lowPrecent = "0.00"
        }
        return item
    }
    
    ///获取高风险资产请求
    func sendHightAssetsRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.getHightAssets(params: paramsDict, completion: {
                [weak self]
                (retDict : NSDictionary)in
                if let instance = self{
                    instance.wrapperFundItem(retDict, riskLevel: The433RiskLevel.HIGHT)
                    instance.needAddTipsItem()
                    completion(retDict)
                }
            }, failed: {
                (faileDict : NSDictionary)in
                failed(faileDict)
            })
    }
    
    ///获取中风险资产请求
    func sendMidAssetsRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.getMidAssets(params: paramsDict, completion: {
                [weak self]
                (retDict : NSDictionary)in
                if let instance = self{
                    instance.wrapperFundItem(retDict, riskLevel: The433RiskLevel.MID)
                    instance.needAddTipsItem()
                    completion(retDict)
                }
            }, failed: {
                (faileDict : NSDictionary)in
                failed(faileDict)
            })
    }
    
    ///获取低风险资产请求
    func sendLowAssetsRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.getLowAssets(params: paramsDict, completion: {
                [weak self]
                (retDict : NSDictionary)in
                if let instance = self{
                    instance.wrapperFundItem(retDict, riskLevel: The433RiskLevel.LOW)
                    instance.needAddTipsItem()
                    completion(retDict)
                }
            }, failed: {
                (faileDict : NSDictionary)in
                failed(faileDict)
            })
    }
    
    ///封装资产信息
    func wrapperFundItem(retDict : NSDictionary,riskLevel : The433RiskLevel){
        let datas = retDict.objectForKey("data") as? NSArray
        if datas?.count > 0{
            //添加数据之前把历史数据清空
            switch(riskLevel){
            case The433RiskLevel.HIGHT:
                self.hightArray?.removeAllObjects()
                break
            case The433RiskLevel.MID:
                self.midArray?.removeAllObjects()
                break
            case The433RiskLevel.LOW:
                self.lowArray?.removeAllObjects()
                break
            }
            for item in datas!{
                let dict = item as? NSDictionary
                let fundItem : FTTHomeResultFundItem = FTTHomeResultFundItem()
                fundItem.name = dict?.objectForKey("name") as? NSString
                fundItem.code = dict?.objectForKey("code") as? NSString
                fundItem.latestPrice = dict?.objectForKey("net") as? NSString
                fundItem.allAssets = dict?.objectForKey("totalAmount") as? NSString
                fundItem.allEarn = dict?.objectForKey("totalProfit") as? NSString
                fundItem.allCount = dict?.objectForKey("share") as? NSString
                fundItem.latestEarn = dict?.objectForKey("latestProfit") as? NSString
                fundItem.latestEarnPercent = dict?.objectForKey("latestYields") as? NSString
                fundItem.latestDate = dict?.objectForKey("dayString") as? NSString
                
                //处理风险级别
                fundItem.type = riskLevel
                
                //处理基金类型
                let kind = dict?.objectForKey("types") as? NSString
                if let kindStr = kind{
                    if kindStr.isEqualToString("债券型"){
                        fundItem.kindType = The433AllType.债券型
                    }else if kindStr.isEqualToString("指数型"){
                        fundItem.kindType = The433AllType.指数型
                    }else if kindStr.isEqualToString("股票型"){
                        fundItem.kindType = The433AllType.股票型
                    }else if kindStr.isEqualToString("混合型"){
                        fundItem.kindType = The433AllType.混合型
                    }
                }
                
                //根据kind 判断该基金的类型
                
                //根据风险类别 封装到不同的数组
                switch(riskLevel){
                    case The433RiskLevel.HIGHT:
                        self.hightArray?.addObject(fundItem)
                    break
                    case The433RiskLevel.MID:
                        self.midArray?.addObject(fundItem)
                    break
                    case The433RiskLevel.LOW:
                        self.lowArray?.addObject(fundItem)
                    break
                }
            }
        }
    }
    
    //是否需要加tipsitem
    func needAddTipsItem() -> Void{
        let tipsItem : FTTHomeResultAddTipsItem = FTTHomeResultAddTipsItem()
        if self.hightArray?.count < 1{
            self.hightArray?.addObject(tipsItem)
        }else if self.midArray?.count < 1{
            self.midArray?.addObject(tipsItem)
        }else if self.lowArray?.count < 1{
            self.lowArray?.addObject(tipsItem)
        }
    }
    
    
    
}
