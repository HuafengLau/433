//
//  FTTHomeAssetsDetailDeleteService.swift
//  the433
//
//  Created by 黄元庆 on 16/1/16.
//  Copyright © 2016年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeAssetsDetailDeleteService: FTTBaseService {
    let baseUrl = "http://liuhuafeng.me/the433/fund/deletefund/"
    
    ///删除某个基金
    func deleteOneFund(params paramsDict:NSDictionary,
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
