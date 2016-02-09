//
//  ViewController.swift
//  the433
//
//  Created by tuan800 on 15/11/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

///现在把有资产基金页面作为rootviewcontroller 所以这个controller暂时不使用 保留后期扩展多tabbar时使用 add 2015-12-18

import UIKit
import Alamofire
public enum HomeTabBarTag : NSInteger{
    case FIRST = 1111
    case SECOND = 1112
    case THIRD = 1113
}

class ViewController: UIViewController ,UITabBarDelegate{

    @IBOutlet weak var homeTabBar: UITabBar!
    
    @IBOutlet weak var firstBar: UITabBarItem!
    
    @IBOutlet weak var secondBar: UITabBarItem!
    
    
    @IBOutlet weak var thirdBar: UITabBarItem!
    
    var allTypeHomeVCL : FTTHomeShowAllTypeVCL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTabBar.delegate = self
        firstBar.tag = HomeTabBarTag.FIRST.rawValue
        secondBar.tag = HomeTabBarTag.SECOND.rawValue
        thirdBar.tag = HomeTabBarTag.THIRD.rawValue
        
        //第一期只要一个界面所以讲tabbar隐藏 根据是否登录和是否拥有一个理财项目确认首页显示规格
        homeTabBar.hidden = true
        
        //未登录或者完全没有理财项目 显示ALLTYPE页面
        
        let storyboard = UIStoryboard.init(name: "FTTHomeShowAllType", bundle: NSBundle.mainBundle())
        allTypeHomeVCL = storyboard.instantiateViewControllerWithIdentifier("FTTHomeShowAllTypeVCL") as? FTTHomeShowAllTypeVCL
        self.navigationController?.pushViewController(allTypeHomeVCL!, animated: false)
        //self.view.addSubview(allTypeHomeVCL!.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let tag : NSInteger = item.tag
        switch(tag){
        case HomeTabBarTag.FIRST.rawValue :
            self.view.backgroundColor = UIColor.colorFromRGB(0x00ffff)
            if let vo : FTTUserVo = FTTDataManager().getUserVo(){
                print("\(vo.account),\(vo.password)\(vo.nickName)");
            }
            break
        case HomeTabBarTag.SECOND.rawValue :
            self.view.backgroundColor = UIColor.colorFromRGB(0xffff00)
            break
        case HomeTabBarTag.THIRD.rawValue :
            //self.view.backgroundColor = UIColor.colorFromRGB(0xff00ff)
            break
        default : break
        }
    }
    
    
    func openAllTypeHome(sourceVCL : UIViewController,params : NSMutableDictionary) -> Void{
        let allTypePage : FTTHomeShowAllTypeVCL = self.creatCTLWithStoryBoardName("FTTHomeShowAllType", identifier: "FTTHomeShowAllTypeVCL") as! FTTHomeShowAllTypeVCL
        allTypePage.params = params
        sourceVCL.navigationController?.pushViewController(allTypePage, animated: true)
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

