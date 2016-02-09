//
//  FTTUserVo.swift
//  the433
//
//  Created by tuan800 on 15/11/24.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTUserVo: NSObject ,NSCoding{
    var account : NSString?
    var password : NSString?
    var nickName : NSString?
    var isNew : NSString?//是否是新用户 用以判断是否显示泡泡页面
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(account, forKey: "account")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(nickName, forKey: "nickname")
        aCoder.encodeObject(isNew, forKey: "isNew")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        account = aDecoder.decodeObjectForKey("account") as? NSString
        password = aDecoder.decodeObjectForKey("password") as? NSString
        nickName = aDecoder.decodeObjectForKey("nickname") as? NSString
        isNew = aDecoder.decodeObjectForKey("isNew") as? NSString
    }
    
    override init() {
        super.init()
    }
}
