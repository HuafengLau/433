//
//  FTTAddHomePageModel.swift
//  the433
//
//  Created by 黄元庆 on 15/12/12.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTAddHomePageModel: FTTBaseModel {
    override init() {
        super.init()
    }
    func loadItemsWithType(type : The433RiskLevel) -> Void{
        self.items?.removeAllObjects()
        switch(type){
            case The433RiskLevel.HIGHT :
                let hItem1 : FTTAddBaseItem = FTTAddBaseItem()
                hItem1.name = "高风险基金"
                hItem1.type = The433RiskLevel.HIGHT
                /*
                let hItem2 : FTTAddBaseItem = FTTAddBaseItem()
                hItem2.name = "高风险2号"
                hItem2.type = The433RiskLevel.HIGHT
                let hItem3 : FTTAddBaseItem = FTTAddBaseItem()
                hItem3.name = "高风险3号"
                hItem3.type = The433RiskLevel.HIGHT
                let hItem4 : FTTAddBaseItem = FTTAddBaseItem()
                hItem4.name = "高风险4号"
                hItem4.type = The433RiskLevel.HIGHT
                let hItem5 : FTTAddBaseItem = FTTAddBaseItem()
                hItem5.name = "高风险5号"
                hItem5.type = The433RiskLevel.HIGHT
                let hItem6 : FTTAddBaseItem = FTTAddBaseItem()
                hItem6.name = "高风险6号"
                hItem6.type = The433RiskLevel.HIGHT
                */
                //self.items?.addObjectsFromArray([hItem1,hItem2,hItem3,hItem4,hItem5,hItem6])
                self.items?.addObjectsFromArray([hItem1])
                break
            case The433RiskLevel.MID :
                let mItem1 : FTTAddBaseItem = FTTAddBaseItem()
                mItem1.name = "中风险基金"
                mItem1.type = The433RiskLevel.MID
                /*
                let mItem2 : FTTAddBaseItem = FTTAddBaseItem()
                mItem2.name = "中风险2号"
                mItem2.type = The433RiskLevel.MID
                let mItem3 : FTTAddBaseItem = FTTAddBaseItem()
                mItem3.name = "中风险3号"
                mItem3.type = The433RiskLevel.MID
                self.items?.addObjectsFromArray([mItem1,mItem2,mItem3])
                */
                self.items?.addObjectsFromArray([mItem1])
                break
            case The433RiskLevel.LOW :
                let lItem1 : FTTAddBaseItem = FTTAddBaseItem()
                lItem1.name = "低风险基金"
                lItem1.type = The433RiskLevel.LOW
                /*
                let lItem2 : FTTAddBaseItem = FTTAddBaseItem()
                lItem2.name = "低风险2号"
                lItem2.type = The433RiskLevel.LOW
                let lItem3 : FTTAddBaseItem = FTTAddBaseItem()
                lItem3.name = "低风险3号"
                lItem3.type = The433RiskLevel.LOW
                let lItem4 : FTTAddBaseItem = FTTAddBaseItem()
                lItem4.name = "低风险4号"
                lItem4.type = The433RiskLevel.LOW
                self.items?.addObjectsFromArray([lItem1,lItem2,lItem3,lItem4])
                */
                self.items?.addObjectsFromArray([lItem1])
                break
        }
    }
}
