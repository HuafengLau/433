//
//  FTTBaseCTL.swift
//  the433
//
//  Created by tuan800 on 15/11/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

public class FTTBaseCTL: UIViewController {
    public var model : FTTBaseModel?
    public var params : NSMutableDictionary?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setparams(params : NSMutableDictionary){
        self.params = params
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
