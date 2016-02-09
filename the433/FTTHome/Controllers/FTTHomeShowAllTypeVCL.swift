//
//  FTTHomeShowAllTypeVCL.swift
//  the433
//
//  Created by tuan800 on 15/11/30.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTHomeShowAllTypeVCL: FTTBaseCTL {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var tipsLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var highRing: UILabel!
    
    @IBOutlet weak var midRing: UILabel!
    
    @IBOutlet weak var lowRing: UILabel!
    
    
    var allTypeArray : NSMutableArray?
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    override func setparams(params: NSMutableDictionary) {
        super.setparams(params)
    }
    
    func setStyle()->Void{
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = FTTColorBlueColor().CGColor
        
        highRing.layer.cornerRadius = 7
        highRing.layer.masksToBounds = true
        midRing.layer.cornerRadius = 7
        midRing.layer.masksToBounds = true
        lowRing.layer.cornerRadius = 7
        lowRing.layer.masksToBounds = true
        
        tipsLabel.text = "了解投资的风险，建议低、中、高\n风险的投资比例是：\n4：3：3"
        
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.setStyle()
        self.model = FTTHomeShowAllTypeModel()
        let model : FTTHomeShowAllTypeModel = self.model as! FTTHomeShowAllTypeModel
        
        model.loadItems()
        
        allTypeArray = model.items
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        
        //打开个人中心
        //隐藏返回bar
        self.navigationController?.navigationItem.hidesBackButton = true
        
        
        let personalButton = UIButton.init(type: .Custom)
        personalButton.setTitle("我", forState: UIControlState.Normal)
        personalButton.adjustsImageWhenHighlighted = false
        personalButton.frame = CGRectMake(0, 0, 44, 44)
        personalButton.addTarget(self, action: "openPersonalHomePage", forControlEvents: .TouchUpInside)
        let leftItem : UIBarButtonItem = UIBarButtonItem.init(customView: personalButton)
        self.navigationItem.leftBarButtonItem = leftItem

        //不需要可以长按拖拽的手势
        //longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        //self.collectionView.addGestureRecognizer(longPressGesture)
        // Do any additional setup after loading the view.
    }
    deinit{
        //print("homealltype page deinit")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openPersonalHomePage(){
        FTTForwardManager.sharedInstance.openPersonalHomePage(self, params: NSMutableDictionary())
    }
    
    /*
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    */
    
    @IBAction func startAction(sender: AnyObject) {
        FTTForwardManager.sharedInstance.openAddFundHomePage(self, params: NSMutableDictionary())
    }
    
    //MARK : Bubble click action
    func clickBubble(item : FTTBubbleItem){
        let page : FTTHomeOneTypeShowDetailView = (NSBundle.mainBundle().loadNibNamed("FTTHomeOneTypeShowDetailView", owner: self, options: nil)).last as! FTTHomeOneTypeShowDetailView
        page.frame = self.view.frame
        page.item = item
        page.setObject()
        self.view.addSubview(page)
        self.view.bringSubviewToFront(page)
        page.startAlphaAnimation()
        self.navigationController?.navigationBar.hidden = true
        page.closeBlock = {
            [weak self]
            ()->Void in
            if let instacne = self{
                //page.removeFromSuperview()
                instacne.navigationController?.navigationBar.hidden = false
            }
        }
    }

}

extension FTTHomeShowAllTypeVCL: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: Int((view.bounds.width - 40)/3), height: 100)
    }
}

extension FTTHomeShowAllTypeVCL: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTypeArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FTTCollectionBubbleViewCell", forIndexPath: indexPath) as! FTTCollectionBubbleViewCell
        //cell.textLabel.text = "\(numbers[indexPath.item])"
        let tempItem : FTTBubbleItem = allTypeArray?.objectAtIndex(indexPath.item) as! FTTBubbleItem
        cell.item = tempItem
        cell.bubbleSet()
        cell.bubbleView.clickBlock = {
            [weak self]
            ()->Void in
            if let instance = self{
                instance.clickBubble(tempItem)
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        //let temp = allTypeArray!.removeObjectAtIndex(sourceIndexPath.item)
        //allTypeArray!.insertObject(temp, atIndex: destinationIndexPath.item)
    }
    
}

//MARK: one little trick
extension CHTCollectionViewWaterfallLayout {
    
    internal override func invalidationContextForInteractivelyMovingItems(targetIndexPaths: [NSIndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [NSIndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContextForInteractivelyMovingItems(targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        
        self.delegate?.collectionView!(self.collectionView!, moveItemAtIndexPath: previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
        
        return context
    }
}




