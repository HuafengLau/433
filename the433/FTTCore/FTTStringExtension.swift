//
//  FTTStringExtension.swift
//  TBCoreDemo
//
//  Created by h on 15/11/12.
//  Copyright © 2015年 enfeng. All rights reserved.
//  copy enfeng

import UIKit

extension String {
    
    public var MD5:String{
        let str : NSString = self as NSString
        return str.MD5 as String
    }
    
    public var urlDecoded:String {
        let str:NSString = self as NSString
        return str.urlDecoded as String
    }
    
    public var percentStr:String{
        let str:NSString = self as NSString
        return str.percentStr as String
    }
    
    public var float_2f:String{
        let str:NSString = self as NSString
        return str.float_2f as String
    }
    
    /// 对url query进行编码
    /// - 如: `http://ss.scom.c/?m=你好&u=<>&tt=test/test&t3=ff|ss`
    /// - 执行后为：`http://ss.scom.c/?m=%E4%BD%A0%E5%A5%BD&u=%3C%3E&tt=test/test&t3=ff%7Css`
    public var urlEncoded:String {
        let str:NSString = self as NSString
        return str.urlDecoded as String
    }
    
    public var encoded:String {
        let str:NSString = self as NSString
        return str.encoded as String
    }
    
    public var jsonValue:NSDictionary {
        let str:NSString = self as NSString
        return str.jsonValue
    }
    
    public var base64EncodedString:String {
        let str:NSString = self as NSString
        return str.base64EncodedString as String
    }
    
    public var base64DecodedString:String? {
        let str:NSString = self as NSString
        return str.base64DecodedString as? String
    }
    
    public func queryDictionaryUsingEncoding(encoding:NSStringEncoding) -> NSDictionary {
        let str:NSString = self as NSString
        return str.queryDictionaryUsingEncoding(encoding)
    }
    /*
    public func stringByAddingQueryDictionary(query:NSDictionary) -> String {
        let str:NSString = self as NSString
        return str.stringByAddingQueryDictionary(query) as String
    }
    */
    public func trim() -> NSString {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}
