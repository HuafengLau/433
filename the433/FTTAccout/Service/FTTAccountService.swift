//
//  FTTAccountService.swift
//  the433
//
//  Created by tuan800 on 15/11/23.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTAccountService: FTTBaseService {
    let baseUrl = "http://liuhuafeng.me/the433/passport/"

    ///登录请求
    func login(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl + "login/"
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
    ///注册请求
    func register(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            let url : String = baseUrl + "register/"
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
    ///修改密码请求
    func changePW(params paramsDict:NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            
    }
    
    func logOut(params paramsDict:NSDictionary,
    completion: (NSDictionary) -> Void,
    failed: (NSDictionary)->Void){
        
    }
    
    
}
