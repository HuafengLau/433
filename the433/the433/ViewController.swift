//
//  ViewController.swift
//  the433
//
//  Created by tuan800 on 15/11/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTabBar.delegate = self
        firstBar.tag = HomeTabBarTag.FIRST.rawValue
        secondBar.tag = HomeTabBarTag.SECOND.rawValue
        thirdBar.tag = HomeTabBarTag.THIRD.rawValue
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
            break
        case HomeTabBarTag.SECOND.rawValue :
            self.view.backgroundColor = UIColor.colorFromRGB(0xffff00)
            break
        case HomeTabBarTag.THIRD.rawValue :
            self.view.backgroundColor = UIColor.colorFromRGB(0xff00ff)
            break
        default : break
        }
    }

    
}

