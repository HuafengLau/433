//
//  FTTHomeFundCountChangeService.swift
//  the433
//
//  Created by 黄元庆 on 15/12/20.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeFundCountChangeService: FTTBaseService {
    let baseUrl = "http://liuhuafeng.me/the433/funddetail/editshare/"
    
    ///修改某只基金份额请求
    func changeFundCount(params paramsDict:NSDictionary,
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
