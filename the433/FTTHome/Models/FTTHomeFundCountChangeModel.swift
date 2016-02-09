//
//  FTTHomeFundCountChangeModel.swift
//  the433
//
//  Created by 黄元庆 on 15/12/20.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeFundCountChangeModel: FTTBaseModel {
    var service : FTTHomeFundCountChangeService?
    
    override init() {
        super.init()
        self.service = FTTHomeFundCountChangeService()
    }
    
    ///发送修改份额请求
    func sendChangeFundCountRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.service?.changeFundCount(params: paramsDict, completion: {
                (retDict : NSDictionary)in
                    completion(retDict)
                }, failed: {
                (faileDict : NSDictionary)in
                    failed(faileDict)
            })
    }
    
}
