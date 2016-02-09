//
//  FTTCommonLoginModel.swift
//  the433
//
//  Created by tuan800 on 15/11/23.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTCommonLoginModel: FTTAccountBaseModel {
    override init() {
        super.init()
    }
    
    func sendLoginRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.accountService?.login(params: paramsDict, completion: {
                (retDict : NSDictionary)in
                completion(retDict)
                }, failed: {
                (faileDict : NSDictionary)in
                failed(faileDict)
            })
    }
}
