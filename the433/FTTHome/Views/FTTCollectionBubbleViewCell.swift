//
//  FTTCollectionBubbleViewCell.swift
//  the433
//
//  Created by tuan800 on 15/11/30.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTCollectionBubbleViewCell: UICollectionViewCell {
    
    var item : FTTBubbleItem?
    
    @IBOutlet weak var bubbleView: FTTPOPBubbleView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    func bubbleSet(){
        if let tempItem = self.item{
            self.bubbleView.item = tempItem
            self.bubbleView.bubbleViewInitWithItem()
        }
        
    }
}
