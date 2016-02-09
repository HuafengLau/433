//
//  FTTNSStringExtension.swift
//  TBCoreDemo
//
//  Created by h on 15/8/5.
//  Copyright © 2015年 h. All rights reserved.
//  copy enfeng

import UIKit

extension NSString {
    public var MD5:NSString!{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        return NSString(format: hash as NSString)
    }
    
    public var urlDecoded:NSString {
        let s1 = self.stringByRemovingPercentEncoding
        var returnString:NSString
        if let s2 = s1 {
            returnString = s2
        } else {
            returnString = self
        }
        
        return returnString
    }
    
    
    //将字符串转化为带两位小数点的字符串
    public var float_2f:NSString{
        var floatStr_2f:NSString
        if self.length > 0{
            let float = self.floatValue
            floatStr_2f = NSString.init(format: "%.2f", float)
        }else{
            floatStr_2f = "0.00"
        }
        return floatStr_2f
    }
    
    //将字符串转化为带两位小数点百分率
    public var percentStr:NSString{
        var floatStr_2f:NSString
        if self.length > 0{
            let float = self.floatValue * 100
            floatStr_2f = NSString.init(format: "%.2f%@", float,"%")
        }else{
            floatStr_2f = "0.00%"
        }
        return floatStr_2f
    }
    
    /// 对url query进行编码
    /// - 如: `http://ss.scom.c/?m=你好&u=<>&tt=test/test&t3=ff|ss`
    /// - 执行后为：`http://ss.scom.c/?m=%E4%BD%A0%E5%A5%BD&u=%3C%3E&tt=test/test&t3=ff%7Css`
    public var urlEncoded:NSString {
        let escapedString:String? = self.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        
        var ret:NSString
        if let s1 = escapedString {
            ret = s1
        } else {
            ret = self
        }
        return ret
    }
    
    public var encoded:NSString {
//        var escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
//        URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
//        URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
//        URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
//        URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
//        URLUserAllowedCharacterSet      "#%/:<>?@[\]^`
        
        let customAllowedSet =  NSCharacterSet(charactersInString:":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`").invertedSet
        let escapedString:String? = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)

        var ret:NSString
        if let s1 = escapedString {
            ret = s1
        } else {
            ret = self
        }
        return ret
    }
    
    public var jsonValue:NSDictionary {
        var ret:NSDictionary = [:]
        
        let data:NSData? = self.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            if let d1 = data {
                ret = try NSJSONSerialization.JSONObjectWithData(d1,
                    options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            }
        } catch {
            
        }
        
        return ret
    }
    
    public var base64EncodedString:NSString {
        let data:NSData? = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        if let d1 = data {
            return d1.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        }
        return self.copy() as! NSString
    }
    
    public var base64DecodedString:NSString? {
        let data:NSData? = NSData(base64EncodedString: self as String,
                    options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        if let d1 = data {
            return NSString(data: d1, encoding: NSUTF8StringEncoding)
        }
        return nil
    }
    
    
    public func queryDictionaryUsingEncoding(encoding:NSStringEncoding) -> NSDictionary {
        let delimiterSet:NSCharacterSet = NSCharacterSet(charactersInString: "&")
        let pairs:NSMutableDictionary = NSMutableDictionary(capacity: 20)
        let scanner:NSScanner = NSScanner(string: self as String)
        while (!scanner.atEnd) {
            var pairString:NSString? = nil
            scanner.scanUpToCharactersFromSet(delimiterSet, intoString: &pairString)
            scanner.scanCharactersFromSet(delimiterSet, intoString: nil)
            let kvPairOpt:NSArray? = pairString?.componentsSeparatedByString("=")
            if let kvPair = kvPairOpt {
                if (kvPair.count==2) {
                    let key:NSString = kvPair[0] as! NSString
                    var value:NSString = kvPair[1] as! NSString
                    value = value.stringByReplacingPercentEscapesUsingEncoding(encoding)!
                    pairs[key] = value
                }
            }
        }
        
        return pairs;
    }
    /*
    public func stringByAddingQueryDictionary(query:NSDictionary) -> NSString {
        let pairs:NSMutableArray = NSMutableArray(capacity: query.count);
        
        let keys:NSEnumerator = query.keyEnumerator()
        for key:AnyObject in keys {
            var value:AnyObject?  = query.safeObjectForKey(key)
            
            if let value1 = value {
                if !value1.isKindOfClass(NSString) {
                    value = value1.stringValue
                }
            } else {
                value = ""
            }
            
            value = value!.stringByReplacingOccurrencesOfString("?", withString: "%3F")
            value = value!.stringByReplacingOccurrencesOfString("?", withString: "%3D")
            
            let pair:NSString = NSString(format:"\(key)=\(value!)")
            
            pairs.addObject(pair)
        }
        let params:NSString = pairs.componentsJoinedByString("&")
        let range:NSRange = self.rangeOfString("?")
        if range.location == NSNotFound {
            return self.stringByAppendingFormat("?\(params)")
        } else {
            return self.stringByAppendingFormat("&\(params)")
        }
    }
    */
    public func trim() -> NSString {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
}
