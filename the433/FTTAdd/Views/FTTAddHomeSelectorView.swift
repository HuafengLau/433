//
//  FTTAddHomeSelectorView.swift
//  the433
//
//  Created by 黄元庆 on 15/12/12.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
typealias addHomePageHighBlock = ()->Void
typealias addHomePageMidBlock = ()->Void
typealias addHomePageLowBlock = ()->Void

class FTTAddHomeSelectorView: UIView {
    @IBOutlet weak var typeBackView: UIView!

    @IBOutlet weak var highButton: UIButton!
    
    @IBOutlet weak var midButton: UIButton!
    
    @IBOutlet weak var lowButton: UIButton!
    
    var highBlock : addHomePageHighBlock?
    var midBlock : addHomePageMidBlock?
    var lowBlock : addHomePageLowBlock?
    
    func setStyle()->Void{
        self.buttonStyleChange(The433RiskLevel.MID)
        self.typeBackView.layer.cornerRadius = 5.0
        self.typeBackView.clipsToBounds = true
    }
    
    @IBAction func highAction(sender: AnyObject) {
        if let myBlock = highBlock{
            self.buttonStyleChange(The433RiskLevel.HIGHT)
            myBlock()
        }
    }
    
    @IBAction func midAction(sender: AnyObject) {
        if let myBlock = midBlock{
            self.buttonStyleChange(The433RiskLevel.MID)
            myBlock()
        }
    }
    
    @IBAction func lowAction(sender: AnyObject) {
        if let myBlock = lowBlock{
            self.buttonStyleChange(The433RiskLevel.LOW)
            myBlock()
        }
    }
    
    func buttonStyleChange(type : The433RiskLevel)->Void{
        switch(type){
            case The433RiskLevel.HIGHT :
                self.highButton.backgroundColor = FTTColorBlueColor()
                self.highButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.midButton.backgroundColor = UIColor.whiteColor()
                self.midButton.setTitleColor(FTTColorBlueColor(), forState: UIControlState.Normal)
                self.lowButton.backgroundColor = UIColor.whiteColor()
                self.lowButton.setTitleColor(FTTColorBlueColor(), forState: UIControlState.Normal)
                break
            case The433RiskLevel.MID :
                self.highButton.backgroundColor = UIColor.whiteColor()
                self.highButton.setTitleColor(FTTColorBlueColor(), forState: UIControlState.Normal)
                self.midButton.backgroundColor = FTTColorBlueColor()
                self.midButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.lowButton.backgroundColor = UIColor.whiteColor()
                self.lowButton.setTitleColor(FTTColorBlueColor(), forState: UIControlState.Normal)
                break
            case The433RiskLevel.LOW :
                self.highButton.backgroundColor = UIColor.whiteColor()
                self.highButton.setTitleColor(FTTColorBlueColor(), forState: UIControlState.Normal)
                self.midButton.backgroundColor = UIColor.whiteColor()
                self.midButton.setTitleColor(FTTColorBlueColor(), forState: UIControlState.Normal)
                self.lowButton.backgroundColor = FTTColorBlueColor()
                self.lowButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                break
        }
    }
}
