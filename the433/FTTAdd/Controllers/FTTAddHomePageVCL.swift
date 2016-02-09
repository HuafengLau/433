//
//  FTTAddHomePageVCL.swift
//  the433
//
//  Created by 黄元庆 on 15/12/12.
//  Copyright © 2015年 tuan800. All rights reserved.
//

import UIKit

class FTTAddHomePageVCL: FTTBaseCTL,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var typeSelectHeadView : FTTAddHomeSelectorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = FTTAddHomePageModel()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .SingleLine

        //将风险筛选的视图作为tableview的表头视图
        let viewArray = NSBundle.mainBundle().loadNibNamed("FTTAddHomeSelectorView", owner: self, options: nil)
        typeSelectHeadView = viewArray[0] as? FTTAddHomeSelectorView
        typeSelectHeadView?.frame = CGRectMake(0, 0, self.view.frame.size.width, 80)
        typeSelectHeadView?.setStyle()
        self.tableView.tableHeaderView = typeSelectHeadView
        typeSelectHeadView?.highBlock = {
            [weak self]
            ()->Void in
            if let instance = self{
                instance.reloadItems(The433RiskLevel.HIGHT)
            }
        }
        typeSelectHeadView?.midBlock = {
            [weak self]
            ()->Void in
            if let instance = self{
                instance.reloadItems(The433RiskLevel.MID)
            }
        }
        typeSelectHeadView?.lowBlock = {
            [weak self]
            ()->Void in
            if let instance = self{
                instance.reloadItems(The433RiskLevel.LOW)
            }
        }
        //声明一个label显示投资风险的提示，作为表尾
        let footLabel : UILabel = UILabel.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        footLabel.textAlignment = NSTextAlignment.Center
        footLabel.text = "风险分类并不代表其真实风险，理财投资需谨慎!\n当前版本仅支持基金理财"
        footLabel.font = UIFont.systemFontOfSize(14)
        footLabel.textColor = UIColor.lightGrayColor()
        footLabel.numberOfLines = 0
        let lay = CALayer.init()
        lay.frame = CGRectMake(0, 0, self.view.frame.size.width, 0.5)
        lay.backgroundColor = UIColor.colorFromRGB(0xd5d5d5).CGColor
        footLabel.layer.addSublayer(lay)
        self.tableView.tableFooterView = footLabel
        
        //默认选中中风险
        self.reloadItems(The433RiskLevel.MID)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadItems(type : The433RiskLevel)-> Void{
        let model : FTTAddHomePageModel = self.model as! FTTAddHomePageModel
        model.loadItemsWithType(type)
        self.tableView.reloadData()
    }
    
    
    //MARK:UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.model?.items?.count{
            return count
        }
        return 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("Identifier")
        if cell == nil{
            cell = UITableViewCell(style:.Default, reuseIdentifier:"Identifier")
        }
        if let tempItem = self.model?.items![indexPath.row]{
            let item = tempItem as? FTTAddBaseItem
            cell!.textLabel?.text = item?.name as? String
            cell!.textLabel?.font = UIFont.systemFontOfSize(14)
        }
        cell!.accessoryType = .DisclosureIndicator
        cell!.selectionStyle = .None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let tempItem = self.model?.items![indexPath.row]{
            let param : NSMutableDictionary = NSMutableDictionary()
            param.setObject(tempItem, forKey: "item")
            FTTForwardManager.sharedInstance.openAddFundEditPage(self, params: param)
        }
    }

}
