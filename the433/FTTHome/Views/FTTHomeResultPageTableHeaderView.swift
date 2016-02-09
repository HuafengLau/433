//
//  FTTHomeResultPageTableHeaderView.swift
//  the433
//
//  Created by 黄元庆 on 15/12/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeResultPageTableHeaderView: UIView {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var yesterdayEarnLabel: UILabel!

    @IBOutlet weak var allAssetsLabel: UILabel!
    
    @IBOutlet weak var allEarnLabel: UILabel!
    
    var item : FTTHomeResultHeaderItem?
    func setStyle(){
        /*
        if let aItem = item{
            if let yesterdayEarn = aItem.yesterdayEarn{
                let earnNumber = yesterdayEarn.floatValue
                if earnNumber < 0{
                    yesterdayEarnLabel.textColor = FTTColorGreenColor()
                }else{
                    yesterdayEarnLabel.textColor = FTTColorRedColor()
                }
            }
            
            if let allEarn = aItem.allEarn{
                let earnNumber = allEarn.floatValue
                if earnNumber < 0{
                    allEarnLabel.textColor = FTTColorGreenColor()
                }else{
                    allEarnLabel.textColor = FTTColorRedColor()
                }
            }

        }
        */

        
        var rect = self.lineView.frame;
        rect.size.height = 0.5;
        self.lineView.frame = rect;

    }
    
    
    func setHeaderView(){
        if let aItem = item{
            if let yesterdayEarn = aItem.yesterdayEarn{
                yesterdayEarnLabel.text = yesterdayEarn as String
            }
            if let allAssets = aItem.allAssets{
                allAssetsLabel.text = allAssets as String
            }
            if let allEarn = aItem.allEarn{
                allEarnLabel.text = allEarn as String
            }
            
            self.setStyle()
        }
    }
}
