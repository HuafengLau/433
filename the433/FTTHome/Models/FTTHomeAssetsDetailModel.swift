//
//  FTTHomeAssetsDetailModel.swift
//  the433
//
//  Created by 黄元庆 on 16/1/16.
//  Copyright © 2016年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeAssetsDetailModel: FTTBaseModel {
    var service : FTTHomeAssetsDetailDeleteService?
    
    override init() {
        super.init()
        self.service = FTTHomeAssetsDetailDeleteService()
    }
    
    ///删除某个基金
    func sendChangeDeleteFundRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.deleteOneFund(params: paramsDict, completion: {
                (retDict : NSDictionary)in
                completion(retDict)
                }, failed: {
                    (faileDict : NSDictionary)in
                    failed(faileDict)
            })
    }
}
