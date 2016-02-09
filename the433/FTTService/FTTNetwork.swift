//
//  FTTNetwork.swift
//  the433
//
//  Created by tuan800 on 15/11/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
import Alamofire
public enum FTTRequestMothod : String{
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

public enum FTTResponseType: Int {
    case JSON, STRING
}

public class FTTNetwork: NSOperation {

    
    public var method:FTTRequestMothod
    public var urlString:String
    var parameters:[String:AnyObject]?
    var aRequest:Request?
    var manager:Manager?
    
    deinit {
        
    }
    
    public init (method: FTTRequestMothod,
        URLString: String,
        parameters: [String: AnyObject]? = nil
        ) {
            
            self.method = method
            self.urlString = URLString
            self.parameters = parameters;
    }
    
    func AFMethod() -> Alamofire.Method {
        var m1:Alamofire.Method
        switch (self.method) {
        case .OPTIONS: m1 = Method.OPTIONS
        case .GET: m1 = Method.GET
        case .HEAD: m1 = Method.HEAD
        case .POST: m1 = Method.POST
        case .PUT: m1 = Method.PUT
        case .PATCH:m1 = Method.PATCH
        case .DELETE :m1 = Method.DELETE
        case .TRACE:m1 = Method.TRACE
        case .CONNECT:m1 = Method.CONNECT
        }
        
        return m1
    }
    
    
    func wrapperErrorResult (entity:FTTRequestEntity) ->Void {
        if entity.error != nil {
            return
        }else{
            if let response1 = entity.response{
                //http协议上的错误提示404 304 500etc.
                entity.error = NSError(domain: "FTT_Domain", code: response1.statusCode, userInfo: nil)
            }else{
                //未知错误
                entity.error = NSError(domain: "FTT_Domain", code: -1, userInfo: nil)
            }
        }
    }
    
    func sendForJson (completionHandler: (FTTRequestEntity) -> Void) -> Void {
        if let req = self.aRequest {
            req.validate(statusCode: 200..<300).responseJSON(completionHandler: {
                closureResponse in
                let response: Response<AnyObject, NSError> = closureResponse
                
                let r1 = FTTRequestEntity()
                r1.request = response.request
                r1.response = response.response
                r1.responseData = response.data
                r1.error = response.result.error
                
                if (response.result.isFailure) {
                    self.wrapperErrorResult(r1)
                } else if let m =  response.result.value {
                    r1.responseJson = m
                }
                completionHandler (r1)
                
            })
        }
    }
    
    func sendForString (completionHandler: (FTTRequestEntity) -> Void) -> Void {
        if let req = self.aRequest {
            req.validate(statusCode: 200..<300).responseString(completionHandler: {
                closureResponse in
                let response: Response<String, NSError> = closureResponse
                
                let r1 = FTTRequestEntity()
                r1.request = response.request
                r1.response = response.response
                r1.responseData = response.data
                
                if (response.result.isFailure) {
                    self.wrapperErrorResult(r1)
                } else if let m =  response.result.value {
                    r1.responseJson = m
                }
                completionHandler (r1)
                
            })
        }
    }
    
    // MARK:
    // MARK: -异步发送请求
    public func send (responseType: FTTResponseType?, completionHandler: (FTTRequestEntity) -> Void) -> Void {
        self.prepareSendRequest()
        if let typ1 = responseType {
            switch (typ1) {
            case .JSON: self.sendForJson(completionHandler)
            case .STRING : self.sendForString(completionHandler)
            }
        } else {
            self.aRequest!.validate(statusCode: 200..<300).response { request, response, data, error in
                
                let r1 = FTTRequestEntity()
                r1.request = request
                r1.response = response
                r1.responseData = data
                r1.error = error
                completionHandler(r1)
            }
        }
    }
    
    public override func cancel() {
        if let req1 = self.aRequest {
            req1.cancel()
        }
        super.cancel()
    }
    
    func prepareSendRequest() -> Void {
        self.aRequest = request(self.AFMethod(), self.urlString, parameters: self.parameters)
    }
}
