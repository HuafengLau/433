//
//  FTTAccountBaseModel.swift
//  the433
//
//  Created by tuan800 on 15/11/24.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTAccountBaseModel: FTTBaseModel {
    var accountService : FTTAccountService?
    override init() {
        super.init()
        let service : FTTAccountService = FTTAccountService()
        
        self.accountService = service
    }
    
}
