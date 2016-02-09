//
//  FTTAddItemsService.swift
//  the433
//
//  Created by 黄元庆 on 15/12/15.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTAddItemsService: FTTBaseService {
    let baseUrl = "http://liuhuafeng.me/the433/fund/useraddfund/"
    
    ///添加基金接口
    func addFund(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl
            self.sendRequest(.POST, URLString: url, parameters: paramsDict as?[String : AnyObject], responseType: .JSON, completionHandler:{
                (requestEntity : FTTRequestEntity)in
                
                let entity : FTTRequestEntity = requestEntity
                if let _ : NSError = requestEntity.error{
                    failed(NSDictionary())
                }else{
                    completion(self.dealSuccuse(entity))
                }
            })
            
    }
    
}
