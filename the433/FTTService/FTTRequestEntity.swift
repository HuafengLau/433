//
//  FTTRequestEntity.swift
//  the433
//
//  Created by tuan800 on 15/11/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTRequestEntity: NSObject {
    public var response:NSHTTPURLResponse?
    public var request:NSURLRequest?
    
    public var responseData:NSData?
    public var responseString:String?
    public var responseJson:AnyObject?
    public var error:NSError?
}
