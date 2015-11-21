//
//  FTTAlertManager.swift
//  the433
//
//  Created by tuan800 on 15/11/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTAlertManager: NSObject {
    public class var sharedInstance: FTTAlertManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: FTTAlertManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = FTTAlertManager()
        }
        return Static.instance!
    }
    
    ///显示较短的提示语 控制10个字符以内
    public func showText(message : String) -> Void{
        SweetAlert().showAlert(message)
    }
    
    ///错误提示 控制10个字符以内
    public func showError(message : String) -> Void{
        SweetAlert().showAlert(message, subTitle: "", style: AlertStyle.Error)
    }
    
    ///成功提示 控制10个字符以内
    public func showSuccuce(message : String) -> Void{
        SweetAlert().showAlert(message, subTitle: "", style: AlertStyle.Success)
    }
    
    
    ///显示较短的提示语 控制10个字符以内
    public func showLongText(message : String) -> Void{
        SweetAlert().showAlert("提示", subTitle: message, style: AlertStyle.None)
    }
    
    ///错误提示 显示较长的错误提示 大概50个字符
    public func showLongError(message : String) -> Void{
        SweetAlert().showAlert("", subTitle: message, style: AlertStyle.Error)
    }
    
    ///成功提示 显示较长的成功提示 大概50个字符
    public func showLongSuccuce(message : String) -> Void{
        SweetAlert().showAlert("", subTitle: message, style: AlertStyle.Success)
    }
    
}
