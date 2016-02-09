//
//  AppDelegate.swift
//  the433
//
//  Created by tuan800 on 15/11/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard.init(name: "FTTHomeResultPage", bundle: NSBundle.mainBundle())
        let homeResultVCL = storyboard.instantiateViewControllerWithIdentifier("FTTHomeResultPageVCL") as? FTTHomeResultPageVCL
        self.window?.rootViewController = UINavigationController.init(rootViewController: homeResultVCL!)
        self.window?.makeKeyAndVisible()
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = UIColor.colorFromRGB(0x4EA8F3)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.checkAPPVersion()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    //检查app版本 每日成功返回一次
    func checkAPPVersion(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = NSDate()
        let todayStr = dateFormatter.stringFromDate(today)
        
        let saveToady = FTTDataManager().getToday()
        if saveToady.characters.count > 1{
            if saveToady == todayStr{
                return;
            }
        }
        
        var version : String = "";
        
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let appDisplayName: AnyObject? = infoDictionary!["CFBundleDisplayName"]
        if let _ = appDisplayName{
            
        }
        
        let majorVersion : AnyObject? = infoDictionary! ["CFBundleShortVersionString"]
        if let build = majorVersion{
            version = build as! String
        }
        
        let minorVersion : AnyObject? = infoDictionary! ["CFBundleVersion"]
        if let _ = minorVersion{
            
        }
        
        let versionService = FTTConfigService()
        let params = ["version" : version]
        versionService.checkAPPVersion(params: params, completion: {
            [weak self]
            (retDict : NSDictionary)in
            if let instance = self{
                instance.showUpDataAlert(retDict)
            }
            }, failed: {
                (faileDict : NSDictionary)in
                
        })
    }
    
    func showUpDataAlert(retDict : NSDictionary){
        var title = "版本过低"
        var detail = "您当前版本过低，请更新至最新版本！"
        let meta = retDict.objectForKey("meta") as? NSDictionary
        if let aMeta = meta{
            let code = aMeta.objectForKey("code") as? NSNumber
            if code?.integerValue == 201{
                let dict = retDict.objectForKey("data") as? NSDictionary
                if let aDict = dict{
                    if let aTitle = aDict.objectForKey("title"){
                        title = aTitle as! String
                    }
                    if let aDetail = aDict.objectForKey("content"){
                        detail = aDetail as! String
                    }
                }
                SweetAlert().showAlert(title, subTitle: detail, style:AlertStyle.Warning,buttonTitle: " 取消 ",buttonColor: UIColor.lightGrayColor(),otherButtonTitle:
                    " 确认 ", action:{
                        [weak self]
                        (isOtherButton : Bool)in
                        if isOtherButton == false{
                            if let instance = self{
                                instance.openAppStore()
                            }
                        }else{
                            if let instance = self{
                                instance.exitApplication()
                            }
                        }
                    })
            }else if code?.integerValue == 200{
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let today = NSDate()
                let todayStr = dateFormatter.stringFromDate(today)
                FTTDataManager().saveToday(todayStr)
            }
            
        }
    }
    
    func openAppStore(){
        let appID = "1078048647"
        let jumpUrl = String.init(format: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", appID)
        UIApplication.sharedApplication().openURL(NSURL.init(string: jumpUrl)!)
    }
    
    func exitApplication(){
        let app = UIApplication.sharedApplication()
        let window = app.windows.last
        UIView.animateWithDuration(1.0, animations: {
            window?.alpha = 0.0
            window?.frame = CGRectMake(0, (self.window?.frame.size.width)!, 0, 0)
            }, completion: {
                bool in
                exit(0)
        })
    }

}

