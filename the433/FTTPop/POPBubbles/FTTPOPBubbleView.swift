//
//  FTTPOPBubbleView.swift
//  the433
//
//  Created by tuan800 on 15/11/30.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit
typealias bubbleClickBlcok = ()->Void
class FTTPOPBubbleView: UIView {
    var bubbleButton : UIButton?
    var item : FTTBubbleItem?
    var hadTouchUpInside : Bool? = false
    var randomAnimation : _POPSpringAnimation = _POPSpringAnimation()
    
    var aWidth : CGFloat = 100
    var aHeight : CGFloat = 100
    
    var clickBlock : bubbleClickBlcok?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func bubbleViewInitWithItem(){
        if let tempItem : FTTBubbleItem = self.item{
            bubbleButton = UIButton.init(frame: CGRectMake(25, 25, 50, 50))
            bubbleButton?.backgroundColor = UIColor.whiteColor()
            bubbleButton?.layer.borderWidth = 0.5
            bubbleButton?.layer.borderColor = tempItem.color?.CGColor
            bubbleButton?.setTitle(tempItem.title as? String, forState: UIControlState.Normal)
            bubbleButton?.setTitleColor(tempItem.color, forState: UIControlState.Normal)
            bubbleButton?.layer.cornerRadius = 25
            bubbleButton?.layer.masksToBounds = true
            bubbleButton?.addTarget(self, action: "touchdown", forControlEvents: UIControlEvents.TouchDown)
            bubbleButton?.addTarget(self, action: "touchcancel", forControlEvents: UIControlEvents.TouchDragExit)
            bubbleButton?.addTarget(self, action: "touchinside", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(bubbleButton!)
            self.animationNextSelect()
        }
    }
    
    
    func touchdown(){
        self.bubbleButton!.pop_removeAllAnimations()
    }
    
    func touchcancel(){
        self.animationRandom()
    }
    
    func touchinside(){
        if hadTouchUpInside == false {
            hadTouchUpInside = true
            if let myBlock = self.clickBlock{
                myBlock()
            }
            print("touch inside and show a page!")
            self.animationRandom()
        }
    }
    
    func animationRandom(){
        self.hadTouchUpInside = false
        self.bubbleButton!.pop_removeAllAnimations()
        randomAnimation = _POPSpringAnimation(tension: 2, friction: 2, mass: 1)
        randomAnimation.property = _POPAnimatableProperty(name: kPOPViewCenter)
        let point : CGPoint = self.bubbleButton!.center
        var pointX = point.x
        var pointY = point.y
        
        //随机位移x
        let countX : CGFloat = 50.0
        let randomX = self.randomInRange(1...99)
        let randomFloatX = CGFloat(randomX)
        let random1 = randomFloatX * (countX / 100.0)
        //随机位移y
        let countY : CGFloat = 50.0
        let randomY = self.randomInRange(1...99)
        let randomFloatY = CGFloat(randomY)
        let random2 = randomFloatY * (countY / 100.0)
        
        pointX = random1 + 25
        pointY = random2 + 25
        
        let betaPoint : CGPoint = CGPointMake(pointX, pointY)
        randomAnimation.toValue = NSValue.init(CGPoint: betaPoint)
        
        _POPAnimation.addAnimation(randomAnimation, key: "center", obj: bubbleButton)
        
        randomAnimation.completionBlock = {
            (anim : _POPAnimation?,finished : Bool) -> Void in
            if finished{
                self.animationNextSelect()
            }
        }
    }
    
    func animationNextSelect(){
        self.animationRandom()
    }
    
    
    
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }

}
