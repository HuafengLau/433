//
//  FTTAddBaseTypePageModel.swift
//  the433
//
//  Created by 黄元庆 on 15/12/15.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTAddBaseTypePageModel: FTTBaseModel {
    var addService : FTTAddItemsService?
    override init() {
        super.init()
        self.addService = FTTAddItemsService()
    }
    
    func sendFundAddRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.addService?.addFund(params: paramsDict, completion: {
                (retDict : NSDictionary)in
                completion(retDict)
                }, failed: {
                (faileDict : NSDictionary)in
                failed(faileDict)
            })
    }
}
