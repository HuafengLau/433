//
//  FTTHomeOneTypeShowDetailView.swift
//  the433
//
//  Created by tuan800 on 15/12/10.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
typealias closeDescriptionPageBlock = ()->Void
class FTTHomeOneTypeShowDetailView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    var closeBlock : closeDescriptionPageBlock?
    //点击关闭按钮
    var startAmt : _POPBasicAnimation = _POPBasicAnimation.init(duration: 2.0)
    var endAmt : _POPBasicAnimation = _POPBasicAnimation.init(duration: 2.0)
    var item : FTTBubbleItem?
    
    func setObject(){
        self.closeButton.layer.cornerRadius = 5.0
        if let oneItem = item{
            titleLabel.text = oneItem.longTitle as? String
            titleLabel.textColor = oneItem.color
            descriptionTextView.text = oneItem.typeDescription as? String
        }
    }
    
    
    func startAlphaAnimation(){
        self.pop_removeAllAnimations()
        startAmt.property = _POPAnimatableProperty(name: kPOPViewAlpha)
        startAmt.fromValue = 0
        startAmt.toValue = 1
        
        _POPAnimation.addAnimation(startAmt, key: "alpha", obj: self)
        
        startAmt.completionBlock = {
            (anim : _POPAnimation?,finished : Bool) -> Void in
            if finished{
                print("alpha finished")
            }
        }
    }
    
    @IBAction func closePageAction(sender: AnyObject) {
        self.closeButton.userInteractionEnabled = false
        if let myBlcok = self.closeBlock{
            myBlcok()
            self.pop_removeAllAnimations()
            endAmt.property = _POPAnimatableProperty(name: kPOPViewAlpha)
            endAmt.fromValue = 1
            endAmt.toValue = 0
            
            _POPAnimation.addAnimation(endAmt, key: "alpha", obj: self)
            
            endAmt.completionBlock = {
                (anim : _POPAnimation?,finished : Bool) -> Void in
                if finished{
                    self.closeButton.userInteractionEnabled = false
                    print("alpha finished")
                    if self.superview != nil{
                        self.removeFromSuperview()
                    }
                }
            }
        }
        
    }

}
