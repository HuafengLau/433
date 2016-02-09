//
//  FTTRegisterModel.swift
//  the433
//
//  Created by tuan800 on 15/11/24.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTRegisterModel: FTTAccountBaseModel {
    override init() {
        super.init()
    }
    
    func sendRegisterRequest(params paramsDict : NSDictionary,
        completion: (NSDictionary) -> Void,
        failed: (NSDictionary)->Void){
            self.accountService?.register(params: paramsDict, completion: {
                (retDict : NSDictionary)in
                    completion(retDict)
                }, failed: {
                    (faileDict : NSDictionary)in
                    failed(faileDict)
            })
    }
}
