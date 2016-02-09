//
//  FTTHomeResultService.swift
//  the433
//
//  Created by 黄元庆 on 15/12/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeResultService: FTTBaseService {
    let baseUrl = "http://liuhuafeng.me/the433/homepage/"
    
    ///获取主资产信息接口
    func getAllAssets(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl + "maininfo/"
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
    ///获取主资产信息接口
    func getHightAssets(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl + "gethighrisk/"
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
    ///获取主资产信息接口
    func getMidAssets(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl + "getmiddlerisk/"
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
    ///获取主资产信息接口
    func getLowAssets(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl + "getlowrisk/"
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
