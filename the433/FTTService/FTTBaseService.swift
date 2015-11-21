//
//  FTTBaseService.swift
//  the433
//
//  Created by tuan800 on 15/11/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTBaseService: NSObject {
    var requestArray:[FTTNetwork] = []
    
    deinit {
        for item in self.requestArray {
            item.cancel()
        }
        self.requestArray.removeAll()
    }
    
    public func sendRequest(
        method: FTTRequestMothod,
        URLString: String,
        parameters: [String: AnyObject]? = nil,
        responseType: FTTResponseType?,
        completionHandler: (FTTRequestEntity) -> Void) -> Void {
            
            let r1:FTTNetwork = FTTNetwork(method: method, URLString: URLString, parameters:parameters)
            self.requestArray.append(r1)
            r1.send(responseType, completionHandler: completionHandler)
    }
}
