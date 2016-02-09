//
//  FTTForwardManager.swift
//  the433
//
//  Created by 黄元庆 on 15/12/18.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTForwardManager: NSObject {
    /**
     * 单例类
     */
    public class var sharedInstance: FTTForwardManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: FTTForwardManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = FTTForwardManager()
        }
        return Static.instance!
    }
    
    ///打开登录页面
    /// - NO PARAMS
    ///
    ///
    public func openLoginPage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let loginVCL : FTTCommonLoginVCL = self.creatCTLWithStoryBoardName("FTTCommonLogin", identifier: "FTTCommonLoginVCL") as! FTTCommonLoginVCL
        loginVCL.paramsDict = params
        sourceVCL.navigationController?.pushViewController(loginVCL, animated: false)
    }
    
    ///打开注册页面
    /// - NO PARAMS
    ///
    ///
    public func openRegisterPage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let loginVCL : FTTRegisterVCL = self.creatCTLWithStoryBoardName("FTTRegister", identifier: "FTTRegisterVCL") as! FTTRegisterVCL
        loginVCL.paramsDict = params
        sourceVCL.navigationController?.pushViewController(loginVCL, animated: true)
    }
    
    ///打开未登录或无资产home页面
    /// - NO PARAMS
    ///
    ///
    public func openHomeAllTypePage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let homeAllTypeVCL : FTTHomeShowAllTypeVCL = self.creatCTLWithStoryBoardName("FTTHomeShowAllType", identifier: "FTTHomeShowAllTypeVCL") as! FTTHomeShowAllTypeVCL
        homeAllTypeVCL.paramsDict = params
        sourceVCL.navigationController?.pushViewController(homeAllTypeVCL, animated: false)
    }
    
    ///打开资产详情页面
    /// :param: item FTTHomeResultFundItem类型的item cell点击的时候传该参数
    ///
    ///
    public func openFundDetailPage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let fundDetailVCL : FTTHomeAssetsDetailVCL = self.creatCTLWithStoryBoardName("FTTHomeAssetsDetail", identifier: "FTTHomeAssetsDetailVCL") as! FTTHomeAssetsDetailVCL
        fundDetailVCL.paramsDict = params
        sourceVCL.navigationController?.pushViewController(fundDetailVCL, animated: true)
    }
    
    ///打开资产添加主页面
    /// - NO PARAMS
    ///
    ///
    public func openAddFundHomePage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let addFundHomeVCL : FTTAddHomePageVCL = self.creatCTLWithStoryBoardName("FTTAddHomePage", identifier: "FTTAddHomePageVCL") as! FTTAddHomePageVCL
        addFundHomeVCL.paramsDict = params
        sourceVCL.navigationController?.pushViewController(addFundHomeVCL, animated: true)
    }
    
    ///打开资产添加填写页面
    /// :param: item FTTAddBaseItem类型的item cell点击的时候传该参数
    ///
    ///
    public func openAddFundEditPage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let addFundEditVCL : FTTAddBaseTypePageVCL = self.creatCTLWithStoryBoardName("FTTAddBaseTypePage", identifier: "FTTAddBaseTypePageVCL") as! FTTAddBaseTypePageVCL
        addFundEditVCL.paramsDict = params
        sourceVCL.navigationController?.pushViewController(addFundEditVCL, animated: true)
    }
    
    ///打开资产修改页面
    /// :param: item FTTHomeResultFundItem类型的item 当前详情页的item
    ///
    ///
    public func openFundCountChangePage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let fundCountChangePage : FTTHomeFundCountChangeCVL = self.creatCTLWithStoryBoardName("FTTHomeFundCountChange", identifier: "FTTHomeFundCountChangeCVL") as! FTTHomeFundCountChangeCVL
        fundCountChangePage.paramsDict = params
        sourceVCL.navigationController?.pushViewController(fundCountChangePage, animated: true)
    }
    
    ///打开个人中心
    /// - NO PARAMS
    ///
    ///
    public func openPersonalHomePage(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let personalHomePage : FTTPersonalHomeVCL = self.creatCTLWithStoryBoardName("FTTPersonalHome", identifier: "FTTPersonalHomeVCL") as! FTTPersonalHomeVCL
        personalHomePage.paramsDict = params
        sourceVCL.navigationController?.pushViewController(personalHomePage, animated: true)
    }
    
    
    
    func creatCTLWithStoryBoardName(name : String,identifier : String) -> UIViewController{
        guard name.isEmpty || identifier.isEmpty else{
            let storyboard = UIStoryboard.init(name: name, bundle: NSBundle.mainBundle())
            let ctl : UIViewController = storyboard.instantiateViewControllerWithIdentifier(identifier)
            return ctl
        }
        
        return Optional.None!
    }
}
