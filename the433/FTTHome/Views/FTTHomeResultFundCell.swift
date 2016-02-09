//
//  FTTHomeResultFundCell.swift
//  the433
//
//  Created by 黄元庆 on 15/12/17.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeResultFundCell: UITableViewCell {
    @IBOutlet weak var fundTypeLabel: UILabel!
    
    @IBOutlet weak var fundNameLabel: UILabel!
    
    @IBOutlet weak var allAssetsLabel: UILabel!
    
    @IBOutlet weak var allEarnLabel: UILabel!
    
    @IBOutlet weak var latestEarnButton: UIButton!
    
    @IBOutlet weak var resultContentView: UIView!

    var item : FTTHomeResultFundItem?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //设置cell的UI  主要是收入是正数和负数的颜色不同
    func setStyle(){
        if let aItem = item{
            var color : UIColor = UIColor()
            if let type = aItem.type{
                switch(type){
                    case The433RiskLevel.HIGHT :
                        color = UIColor.redColor()
                        break
                    case The433RiskLevel.MID :
                        color = UIColor.orangeColor()
                        break
                    case The433RiskLevel.LOW :
                        color = UIColor.blueColor()
                        break
                }
                self.fundTypeLabel.layer.cornerRadius = self.fundTypeLabel.frame.size.width/2.0
                self.fundTypeLabel.layer.borderWidth = 1
                self.fundTypeLabel.layer.borderColor = color.CGColor
                self.fundTypeLabel.textColor = color
                
                if let earn = aItem.latestEarn{
                    let earnFloat : Float = earn.floatValue
                    self.latestEarnButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    if earnFloat < 0{
                        self.latestEarnButton.backgroundColor = FTTColorGreenColor()
                    }else{
                        self.latestEarnButton.backgroundColor = FTTColorRedColor()
                    }
                    
                    let title = self.latestEarnButton.titleLabel?.text
                    if title?.characters.count < 1{
                        self.latestEarnButton.hidden = true
                        return
                    }else{
                        self.latestEarnButton.hidden = false
                    }
                    
                    let defualtTitle = "-99.99"
                    let defualtSize = defualtTitle.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(14)])
                    
                    var size = title!.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(14)])
                    if size.width < defualtSize.width{
                        size.width = defualtSize.width;
                    }
                    
                    let width = self.resultContentView.frame.size.width
                    let originX = width - size.width - 10 - 10;
                    
                    var rect = self.latestEarnButton.frame
                    rect.origin.x = originX
                    rect.size.width = size.width + 10
                    self.latestEarnButton.frame = rect
                    
                    self.latestEarnButton.layer.cornerRadius = 5.0
                }
            }
        }
    }
    
    func setCellWithItem(){
        self.latestEarnButton.selected = false
        if let aItem = item{
            self.fundTypeLabel.text = aItem.kindType?.rawValue as? String
            self.fundNameLabel.text = aItem.name as? String
            self.allAssetsLabel.text = aItem.allAssets as? String
            self.allEarnLabel.text = aItem.allEarn as? String
            let earn = aItem.latestEarn as? String
            if earn != nil{
                self.latestEarnButton.setTitle(earn, forState: UIControlState.Normal)
            }
            self.setStyle()
        }
    }
    
    @IBAction func changeEarnShowTypeAction(sender: AnyObject) {
        if let aItem = item{
            self.latestEarnButton.selected = !self.latestEarnButton.selected
            if self.latestEarnButton.selected{
                let earnPercentStr = aItem.latestEarnPercent as? String
                if earnPercentStr != nil{
                    self.latestEarnButton.setTitle(earnPercentStr?.percentStr, forState: UIControlState.Normal)
                }
            }else{
                let earn = aItem.latestEarn as? String
                if earn != nil{
                    self.latestEarnButton.setTitle(earn?.float_2f, forState: UIControlState.Normal)
                }
            }
            self.setStyle()
        }
    }

}
