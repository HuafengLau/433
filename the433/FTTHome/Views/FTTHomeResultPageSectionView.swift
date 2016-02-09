//
//  FTTHomeResultPageSectionView.swift
//  the433
//
//  Created by 黄元庆 on 15/12/16.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeResultPageSectionView: UIView {
    
    @IBOutlet weak var typeTitleLabel: UILabel!
    
    @IBOutlet weak var percentLabel: UILabel!
    
    var item : FTTHomeResultTableSectionItem?
    
    func setSectionView(){
        if let aItem = item{
            if let type = aItem.type{
                switch(type){
                case The433RiskLevel.HIGHT :
                    typeTitleLabel.text = "高风险"
                    break
                case The433RiskLevel.MID :
                    typeTitleLabel.text = "中风险"
                    break
                case The433RiskLevel.LOW :
                    typeTitleLabel.text = "低风险"
                    break
                }
                
                if let percent = aItem.percent{
                    percentLabel.text = percent.percentStr as String
                }
            }
        }
    }

}
