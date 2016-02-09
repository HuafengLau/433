//
//  FTTBaseCTL.swift
//  the433
//
//  Created by tuan800 on 15/11/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTBaseCTL: UIViewController {
    var activityBackView : UIView?
    var activityView : UIActivityIndicatorView?
    var pageloading : Bool?
    
    public var model : FTTBaseModel?
    public var params : NSMutableDictionary?
    public var paramsDict : NSMutableDictionary = NSMutableDictionary()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setparams(paramsDict)
        pageloading = false
        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setparams(params : NSMutableDictionary){
        self.params = params
    }
    

    func initLoadingView(){
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        
        if self.activityBackView == .None{
            self.activityBackView = UIView.init(frame: CGRectMake(0, 0, width, height))
            self.activityBackView?.backgroundColor = UIColor.init(white: 0.20, alpha: 0.75)
        }
        
        if self.activityView == .None{
            self.activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            self.activityView?.frame = CGRectMake((width/2 - 75), (height/2 - 75), 150, 150)
            self.activityView?.hidesWhenStopped = true
            self.activityView?.color = UIColor.whiteColor()
            self.activityBackView?.addSubview(self.activityView!)
            self.activityView?.startAnimating()
        }
        
        self.view.backgroundColor = UIColor.colorFromRGB(0xf1f1f1)
    }
    
    
    //loading
    func startLoading() -> Void{
        self.pageloading = true
        self.initLoadingView()
        self.view.addSubview(self.activityBackView!)
    }
    
    func stopLoading() -> Void{
        self.pageloading = false
        if self.activityBackView != .None{
            self.activityBackView?.removeFromSuperview()
        }
    }
    
    
    func toolBar() -> UIToolbar{
        let toolbar = UIToolbar.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 35))
        toolbar.barStyle = UIBarStyle.BlackTranslucent
        toolbar.translucent = true
        let barButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let barItem1 = UIBarButtonItem.init(title: "收起键盘", style: UIBarButtonItemStyle.Done, target: self, action: Selector("hideKeyBoard"))
        
        let arr = [barButtonItem,barItem1]
        toolbar.items = arr
        return toolbar
        
    }

}
